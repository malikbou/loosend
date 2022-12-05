class ReviewsController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:create]
  before_action :set_toilet, only: %i[new create]

  def create
    if user_signed_in?
      @review = Review.new(review_params)
      @review.toilet = @toilet
      @review.user = current_user
      @markers = [
        {
          lat: @toilet.latitude,
          lng: @toilet.longitude,
          info_window: render_to_string(partial: "info_window", locals: {toilet: @toilet}),
          image_url: helpers.asset_url("toilet-paper.png")
        }
      ]
      if @review.save
        redirect_to review_path(@review)
      else
        render "toilets/show", status: :unprocessable_entity
      end
    else
      flash[:alert] = "You need to be logged in to leave a review."
      redirect_to new_user_session_path
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
    params.require(:review).permit(:toilet_rating, :comment)
  end
end
