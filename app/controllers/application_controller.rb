class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :redirect_root_domain

  private

  def redirect_root_domain
    if Rails.env.production?
      if request.host === "loosend.co"
        redirect_to "https://www.loosend.co#{request.fullpath}", status: 301
      end
    end
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end
end
