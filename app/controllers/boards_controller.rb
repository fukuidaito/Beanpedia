class BoardsController < ApplicationController
  include BoardsHelper
  before_action :set_board, only: %i[edit update destroy show]
  before_action :authenticate_user!, except: [:show]

  def index
    @q = Board.ransack(params[:q])
    @boards = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page]).per(9)
  end

  def search
    if params[:title_search].present?
      search_term = params[:title_search].downcase
      @boards = Board.where('LOWER(title) LIKE ?', "%#{search_term}%").order(created_at: :desc)
    else
      @boards = []
    end
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update('search_results',
                                                 partial: 'boards/search_results',
                                                 locals: { boards: @boards })
      end
    end
  end

  def show
    @comment = Comment.new
    @comments = @board.comments.includes(:user).order(created_at: :desc)
    @review = Review.new
    @reviews = @board.reviews.order('created_at desc')
    @has_review = @reviews.find_by(user_id: current_user.id) if current_user
    prepare_meta_tags(@board)
  end

  def new
    @board = Board.new
    @board.board_images.build
  end

  def edit
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      if params[:board][:board_images_files].present?
        params[:board][:board_images_files].each do |image|
          @board.board_images.create(image:)
        end
      end
      redirect_to boards_path, success: t('.success')
    else
      flash.now[:danger] = t('.board_failure') and render :new, status: :unprocessable_entity
    end
  end

  def update
    if @board.update(board_params)
      if params[:board][:board_images_files].present?
        params[:board][:board_images_files].each do |image|
          @board.board_images.create(image:)
        end
      end
      redirect_to @board, success: t('defaults.message.updated', item: Board.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_updated', item: Board.model_name.human)
      render :edit
    end
  end

  def destroy
    board = current_user.boards.find(params[:id])
    board.destroy!
    redirect_to boards_path, status: :see_other, success: t('defaults.flash_message.deleted', item: Board.model_name.human)
  end

  def bookmarks
    @q = current_user.bookmark_boards.ransack(params[:q])
    @bookmark_boards = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def ranking
    @boards = Board.ranking.limit(10)
  end

  private

  def set_board
    @board = params[:action] == 'show' ? Board.find(params[:id]) : current_user.boards.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:title, :body, :acidity, :bitterness, :richness, :address, :latitude, :longitude, :stars,
                                  board_images_files: [])
  end

  def prepare_meta_tags(board)
    set_meta_tags(
      title: board.title,
      description: board.body,
      image: board.image_url,
      og: {
        title: board.title,
        description: board.body,
        image: board.image_url,
        url: request.url,
        type: 'article'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@zutozako1',
        title: board.title,
        description: board.body,
        image: board.image_url
      }
    )
  end

  def line_client
    @line_client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV.fetch('LINE_CHANNEL_SECRET', nil)
      config.channel_token = ENV.fetch('LINE_CHANNEL_TOKEN', nil)
    end
  end
end
