class BoardsController < ApplicationController

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
    redirect_to index_boards_path, status: :see_other, success: t('defaults.flash_message.deleted', item: Board.model_name.human), status: :see_other
  end

  def show; end

  private

	def set_board
    @board = current_user.boards.find(params[:id])
  end

	def board_params
		params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
	end
end
