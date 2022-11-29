class ReviewsController < ApplicationController
  def all
    @reviews = Review.all
  end

  def new
    @review = Review.new
  end

  def show
    @review = Review.find(params[:id])
  end

  def create
    @toilet = Toilet.find(params[:toilet_id])
    @review = Review.new(review_params)
    @review.toilet = @toilet
    @review.user = current_user

    if @review.save
      redirect_to toilet_review_path(@review)
    else
      render template: "toilets/show", status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:reviews).permit(:toilet_rating)
  end
end
