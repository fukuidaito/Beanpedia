class BoardsController < ApplicationController
  include BoardsHelper
  before_action :set_board, only: %i[edit update destroy]
  before_action :authenticate_user!, except: [:show]
  skip_before_action :authenticate_user!, only: [:show]

  def index
    @q = Board.ransack(params[:q])
    @boards = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
    @pagy, @boards = pagy(Board.all, items: 10)
  end

  def search
    if params[:title_search].present?
      search_term = params[:title_search].downcase  # パラメータを小文字に変換
      @boards = Board.where('LOWER(title) LIKE ?', "%#{search_term}%").order(created_at: :desc)
    else
      @boards = []  # クエリが空の場合は空の配列を返す
    end
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("search_results",
          partial: "boards/search_results",
          locals: { boards: @boards })
      end
    end
  end

  def show
    @board = Board.find(params[:id])
    @comment = Comment.new
    @comments = @board.comments.includes(:user).order(created_at: :desc)
  end

  def new
    @board = Board.new
  end

  def edit
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to boards_path, success: t('.success')
    else
      flash.now[:danger] = t('.board_failure') and render :new, status: :unprocessable_entity
    end
  end

  def update
    if @board.update(board_params)
      redirect_to @board, success: t('defaults.message.updated', item: Board.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_updated', item: Board.model_name.human)
      render :edit
    end
  end

  def destroy
    board = current_user.boards.find(params[:id])
    board.destroy!
    redirect_to boards_path, status: :see_other, success: t('defaults.flash_message.deleted', item: Board.model_name.human),
                             status: :see_other
  end

  # def bookmarks
  #   @bookmark_boards = current_user.bookmark_boards.includes(:user).order(created_at: :desc)
  # end

  def bookmarks
    @q = current_user.bookmark_boards.ransack(params[:q])
    @bookmark_boards = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def ranking
    @boards = Board.ranking.limit(10)
  end



  private

  def set_board
    @board = current_user.boards.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache, :acidity, :bitterness, :richness, :address, :latitude, :longitude, :rating).tap do |whitelisted|
      whitelisted[:rating] = whitelisted[:rating].to_i if whitelisted[:rating]
    end
  end

  def rate
    board = Board.find(params[:id])
    board.rating = params[:rating]
    board.save
  end

  def line_client
    @line_client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    }
  end
end
