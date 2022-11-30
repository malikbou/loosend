class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @toilets = Toilet.all
    @markers = @toilets.geocoded.map do |toilet|
      {
        lat: toilet.latitude,
        lng: toilet.longitude,
        info_window: render_to_string(partial: "info_window", locals: {toilet: toilet}),
        image_url: helpers.asset_url("pin.png")
      }
    end
  end
end
