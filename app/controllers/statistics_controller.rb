class StatisticsController < ApplicationController
  helper_method :sort_direction, :sort_column

  before_filter :ensure_json_request, only: [:chart_data]
  before_action :authenticate_user!

  def index
    data_service = StatisticsDataService.new
    @data = data_service.period_views

    self_search = !params[:scope].nil? && params[:scope].to_bool ? true : false
    search_service = UpdateMailSearchService.new
    @latest_update_mails = search_service.search(params[:search], current_user, self_search)
                        .where('sent = true')
                        .order('update_mails.sent_at DESC')
                        .limit(10)
  end

  # Returns chart related Data as JSON
  def chart_data
    data_service = StatisticsDataService.new
    render json: data_service.chart_data
  end

  private

  def sort_column
    UpdateMail.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
  end
end
