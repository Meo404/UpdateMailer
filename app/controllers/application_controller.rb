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

  # Method to validate whether or not the request is a JSON request
  # if it is json request then proceed
  # else render nothing with status code 406
  def ensure_json_request
    return if params[:format] == 'json' || request.headers['Accept'] =~ /json/
    render nothing: true, status: 406
  end

  # Method to check whether or not the current user has the admin role
  # if he is admin nothing happens
  # else he will be redirected to the root_path
  def check_admin
    redirect_to :root unless current_user && current_user.admin?
  end
end
