class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :redirect_root_domain

  private

  def redirect_root_domain
    return unless request.host === 'loosend.co'

    redirect_to("#{request.protocol}www.loosend.co#{request.fullpath}", status: 301)
  end
end
