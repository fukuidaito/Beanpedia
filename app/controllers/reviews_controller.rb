class ReviewsController < ApplicationController
  def create
    if Review.exists?(board_id: review_params[:board_id], user_id: current_user.id)
    flash[:alert] = "レビュー済みです。"
    else
    @review = Review.create(review_params)
    board = @review.board
    if @review.save
        flash[:notice] = "レビューを投稿しました。"
    else
        flash[:alert] = "レビューできません"
    end
    end
    redirect_to request.referrer
  end
    
  def destroy
    @review = Review.find(params[:id])
    board = @review.board
    @review.destroy
    flash[:alert] = "レビューを削除しました。"
    redirect_to board
  end
    
private
    
  def review_params
      params.require(:review).permit(:stars, :review, :board_id, :user_id)
  end
end
  