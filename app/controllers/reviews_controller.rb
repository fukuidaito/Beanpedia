class ReviewsController < ApplicationController
  def create
    if Review.exists?(board_id: review_params[:board_id], user_id: current_user.id)
      flash[:alert] = t('reviews.already_reviewed')
    else
      @review = Review.create(review_params)
      if @review.save
        flash[:notice] = t('reviews.success')
      else
        flash[:alert] = t('reviews.failure')
      end
    end
    redirect_to request.referer
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:alert] = t('reviews.deleted')
    redirect_to @review.board
  end

  private

  def review_params
    params.require(:review).permit(:stars, :review, :board_id, :user_id)
  end
end
