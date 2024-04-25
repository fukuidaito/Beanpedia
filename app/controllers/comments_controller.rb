class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:update, :destroy]
  before_action :set_board, only: [:index, :create]

  def update
    if @comment.update(comment_params)
      redirect_to @comment.board, notice: 'コメントが更新されました。'
    else
      render :edit
    end
  end


  def destroy
    board = @comment.board
    @comment.destroy
    redirect_to board, alert: 'コメントが削除されました。'
  end
  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      redirect_to board_path(comment.board)
    else
      redirect_to board_path(comment.board)
    end
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
