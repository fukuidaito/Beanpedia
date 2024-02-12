class BoardsController < ApplicationController
  before_action :set_board, only: %i[edit update destroy]

	def new
		@board = Board.new
	end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to boards_path, success: t('.success')
    else
      flash.now[:danger] = t('.board_failure')
      render :new, status: :unprocessable_entity
    end
  end

	def index
		@boards = Board.all.includes(:user).order(created_at: :desc)
	end

  def edit; end

  def destroy
    board = current_user.boards.find(params[:id])
    board.destroy!
    redirect_to boards_path, status: :see_other, success: t('defaults.flash_message.deleted', item: Board.model_name.human), status: :see_other
  end


  def show
    @board = Board.find(params[:id])
    @comment = Comment.new
    @comments = @board.comments.includes(:user).order(created_at: :desc)
  end

  def update
    if @board.update(board_params)
      redirect_to @board, success: t('defaults.message.updated', item: Board.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_updated', item: Board.model_name.human)
      render :edit
    end
  end

  private

	def set_board
    @board = current_user.boards.find(params[:id])
  end

	def board_params
		params.require(:board).permit(:title, :body, :board_image, :board_image_cache, :acidity, :bitterness, :richness)
	end
end
