class ToiletsController < ApplicationController
  def index
    @toilets = Toilets.all
  end

  def show
    @review = Review.new
    @toilet = Toilet.find(params[:id])
  end

  private

  def toilet_params
    params.require(:toilets).permit(:name, :address, :opens_at, :closes_at, :fee, :toilet_code, :rating)
  end
end
