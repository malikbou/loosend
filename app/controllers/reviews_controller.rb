class ReviewsController < ApplicationController
  before_action :set_toilet, only: %i[new create]

  def all
    @reviews = Review.all
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.toilet = @toilet
    @review.user = current_user
    if @review.save
      redirect_to review_path(@review)
    else
      render template: "new", status: :unprocessable_entity
      # render template: "toilets/show", status: :unprocessable_entity
    end
  end

  def show
    @review = Review.find(params[:id])
  end

  def review_confirmation
    @review = Review.find(params[:id])
    @markers = {
      info_window: render_to_string(partial: "info_window", locals: {toilet: @review.toilet}),
      # image_url: helpers.asset_url("pin.png")
    }
  end

  private

  def set_toilet
    @toilet = Toilet.find(params[:toilet_id])
  end

  def review_params
    params.require(:review).permit(:toilet_rating, :hygiene_rating, :comment)
  end
end
