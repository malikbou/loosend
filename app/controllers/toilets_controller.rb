class ToiletsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_toilet, only: [:show]

  "SELECT DISTINCT t.id
    , t.address
    , t.opens_at
    , t.closes_at
    , t.fee
    , t.toilet_code
    , t.rating
    , t.created_at
    , t.updated_at
    , t.latitude
    , t.longitude
  FROM toilets t
      INNER JOIN toilet_features tf
          ON tf.toilet_id = t.id
      INNER JOIN features f
          ON f.id = tf.feature_id
              WHERE f.name IN ('Accessible', 'Mirror')"

  "WITH r AS
    (SELECT t.*
      , ROW_NUMBER() OVER(ORDER BY tf.feature_id ASC) AS row
      FROM toilets t
      RIGHT JOIN toilet_features tf
          ON tf.toilet_id = t.id
              WHERE tf.feature_id in (8, 5, 1))
    SELECT DISTINCT id
    , name
    , CASE
        WHEN row = 1 THEN 'has 1 feature'
        WHEN row = 2 THEN 'has 2 features'
        WHEN row = 3 THEN 'has 3 features'
      END
    , address
    , opens_at
    , closes_at
    , fee
    , toilet_code
    , rating
    , created_at
    , updated_at
    , latitude
    , longitude
    FROM r
    ORDER BY id ASC
  "

  # Toilet.joins(toilet_features: :features)
  #   .where("features.name = 'Accessible' AND features.name = 'Mirror'")




  def index
    @lewagon_coordinates = [51.53, -0.07]

    if params[:format].present?
      @name = params[:format].split('/')
      features = Feature.where(name: @name)
      @toilets = Toilet.includes(:features).where('features.name' => @name[0])
      @toilets = @toilets.where('features.name' => @name[1])
      @toilets = Toilet.includes(:features).where('features.name' => @name)

    # if params[:format].present?
    #   feature = Feature.where("name = '#{params[:format]}'")
    #   @name = feature[0].name
    #   @toilets = feature[0].toilets.near(@lewagon_coordinates, 20, :order => :distance)
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
  end

  private

  def set_toilet
    @toilet = Toilet.find(params[:id])
  end
end
