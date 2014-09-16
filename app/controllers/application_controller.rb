class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :load_session

  private

  def load_session
    session[:init] = true
    logger.info "Session Loaded."
  end
end
