class ReviewsController < ApplicationController
  before_action :set_toilet, only: %i[new create]

  def create
    @review = Review.new(review_params)
    @review.toilet = @toilet
    @review.user = current_user
    if @review.save
      redirect_to review_path(@review)
    else
      render template: "new", status: :unprocessable_entity
    end
  end

  def show
    @review = Review.find(params[:id])
  end

  private

  def set_toilet
    @toilet = Toilet.find(params[:toilet_id])
  end

  def review_params
    params.require(:review).permit(:toilet_rating, :hygiene_rating, :comment)
  end
end
