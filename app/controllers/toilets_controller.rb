class ToiletsController < ApplicationController
  before_action :set_toilet, only: [:show]

  def index
    @toilets = Toilet.all
    @markers = @toilets.geocoded.map do |toilet|
      {
        lat: toilet.latitude,
        lng: toilet.longitude,
        info_window: render_to_string(partial: "info_window", locals: {toilet: toilet}),
        image_url: helpers.asset_url("toilet-paper.png")
      }
    end
  end

  def show
    @toilet = Toilet.find(params[:id])
    @review = Review.new
    @reviews = Review.where(toilet_id: params[:id])
    @toilets = Toilet.all
    @markers = @toilets.geocoded.map do |toilet|
      {
        lat: toilet.latitude,
        lng: toilet.longitude,
        info_window: render_to_string(partial: "info_window", locals: {toilet: toilet}),
        image_url: helpers.asset_url("toilet-paper.png")
      }
    end
    @marker = {
      lat: @toilet.latitude,
      lng: @toilet.longitude,
      info_window: render_to_string(partial: "info_window", locals: {toilet: @toilet}),
      image_url: helpers.asset_url("pin.png")
    }
  end

  private

  def set_toilet
    @toilet = Toilet.find(params[:id])
  end
end
