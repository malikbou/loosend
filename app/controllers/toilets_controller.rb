class ToiletsController < ApplicationController
  before_action :set_toilet, only: [:show, :edit, :update, :destroy]

  def index
    if params[:query].present?
      @toilets = Toilet.search_by_name_address_description_category(params[:query])
    else
      @toilets = Toilet.all
    end
  end

  def new
    @toilet = Toilet.new
  end

  # def show
  #   @review = Review.new
  #   @toilet = Toilet.find(params[:id])
  #   @markers = {
  #         lat: @toilet.latitude,
  #         lng: @toilet.longitude,
  #         info_window: render_to_string(partial: "info_window", locals: {toilet: @toilet}),
  #         image_url: helpers.asset_url("pin.png")
  #       }
  # end

  def create
    @toilet = Toilet.new(toilet_params)
    @toilet.user = current_user
    if @toilet.save
      redirect_to toilet_path(@toilet)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @toilet = Toilet.find(params[:id])
  end

  def update
    @toilet = Toilet.find(params[:id])
    @toilet.update(toilet_params)
    redirect_to toilet_path(@toilet)
  end

  def destroy
    @toilet = Toilet.find(params[:id])
    @toilet.destroy
    redirect_to toilets_path, status: :see_other
  end

  private

  def set_toilet
    @toilet = Toilet.find(params[:id])
  end

  def toilet_params
    params.require(:toilet).permit(:name, :address, :opens_at, :closes_at, :fee, :toilet_code, :rating)
  end
end
