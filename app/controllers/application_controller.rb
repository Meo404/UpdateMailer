class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Function to set sort directions for tables
  # @param  default optional parameter to set the default sort direction
  # @return Returns sort direction
  def sort_direction(default = 'asc')
    %w(asc desc).include?(params[:direction]) ? params[:direction] : default
  end
end
