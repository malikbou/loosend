class ToiletsController < ApplicationController
  before_action :set_toilet, only: [:show]

  def index
    @lewagon_coordinates = [51.53, -0.07]
    if params[:format].present?
      feature = Feature.where("name = '#{params[:format]}'")
      @name = feature[0].name
      @toilets = feature[0].toilets.near(@lewagon_coordinates, 20, :order => :distance)
    else
      @toilets = Toilet.near(@lewagon_coordinates, 20, :order => :distance)
    end
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
    @markers = [
      {
        lat: @toilet.latitude,
        lng: @toilet.longitude,
        info_window: render_to_string(partial: "info_window", locals: {toilet: @toilet}),
        image_url: helpers.asset_url("toilet-paper.png")
      }
    ]
    @marker = {
      lat: @toilet.latitude,
      lng: @toilet.longitude,
      info_window: render_to_string(partial: "info_window", locals: {toilet: @toilet}),
      image_url: helpers.asset_url("pin.png")
    }
    @avgrating = @toilet.reviews.pluck(:toilet_rating).sum/@toilet.reviews.pluck(:toilet_rating).count.to_f
  end

  private

  def set_toilet
    @toilet = Toilet.find(params[:id])
  end
end
