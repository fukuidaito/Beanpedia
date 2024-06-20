class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :set_board, only: [:index, :create]

  def index
    @comments = @board.comments.order(created_at: :desc)
  end

  def edit
  end

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:success] = t('.success')
      redirect_to board_path(@comment.board)
    else
      flash[:danger] = t('.failure')
      redirect_to board_path(@comment.board)
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to board_path(@comment.board), notice: t('.success') }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    board = @comment.board
    @comment.destroy
    redirect_to board, success: t('.success')
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_board
    @board = Board.find(params[:board_id])
  end

  def comment_params
    params.require(:comment).permit(:body).merge(board_id: params[:board_id])
  end
end
