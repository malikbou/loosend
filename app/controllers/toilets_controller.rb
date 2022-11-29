class ToiletsController < ApplicationController
  before_action :set_toilet, only: [:show]

  def show
    @toilet = Toilet.find(params[:id])
    @review = Review.new
    @reviews = Review.where(toilet_id: params[:id])
  end

  # def toilet_reviews
  #   @reviews = Review.where(toilet_id: params[:id])
  # end

  private

  def set_toilet
    @toilet = Toilet.find(params[:id])
  end

  # def toilet_params
  #   params.require(:toilets).permit(:name, :address, :opens_at, :closes_at, :fee, :toilet_code, :rating)
  # end
end
