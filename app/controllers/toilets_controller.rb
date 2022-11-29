class ToiletsController < ApplicationController
  before_action :set_toilet, only: [:index, :show]

  def index
    @toilets = Toilet.all
  end

  def show
    @review = Review.new
  end

  private

  def set_toilet
    @toilet = Toilet.find(params[:id])
  end

  def toilet_params
    params.require(:toilets).permit(:name, :address, :opens_at, :closes_at, :fee, :toilet_code, :rating)
  end
end
