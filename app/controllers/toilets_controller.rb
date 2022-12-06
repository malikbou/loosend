class ToiletsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_toilet, only: [:show]

  def index
    @lewagon_coordinates = [51.53, -0.07]
    if params[:feature_ids].present?
      @features = Feature.where(id: params[:feature_ids])
      @toilets = Toilet.with_features(@features).near(@lewagon_coordinates, 20, :order => :distance)
    else
      @toilets = Toilet.near(@lewagon_coordinates, 20, :order => :distance)
    end
    @markers = @toilets.geocoded.map do |toilet|
      {
        lat: toilet.latitude,
        lng: toilet.longitude,
        info_window: render_to_string(partial: "info_window", locals: { toilet: toilet }),
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
        info_window: render_to_string(partial: "info_window", locals: { toilet: @toilet }),
        image_url: helpers.asset_url("toilet-paper.png")
      }
    ]

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
