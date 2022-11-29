class ReviewsController < ApplicationController
  def all
    @reviews = Review.all
  end

  def new
    @review = Review.new
  end

  def create
    @toilet = Toilet.find(params[:toilet_id])
    @review = Review.new(review_params)
    @review.toilet = @toilet
    @review.user = current_user
    if @review.save
      redirect_to review_confirmation_path(@review)
    else
      render template: "toilets/show", status: :unprocessable_entity
    end
  end

  def review_confirmation
    @review = Review.find(params[:id])
    @markers = {
      lat: @review.toilet.latitude,
      lng: @review.toilet.longitude,
      info_window: render_to_string(partial: "info_window", locals: {toilet: @review.toilet}),
      image_url: helpers.asset_url("pin.png")
    }
  end

  def my_reviews
    @reviews = Review.where(user_id: current_user.id)
  end

  private

  def review_params
    params.require(:review).permit(:start_date, :end_date)
  end
end
