# Base controller for the application
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :force_amp, if: -> { request.path_parameters[:amp] }

  private

  def force_amp
    request.format = "amp"
  end
end
