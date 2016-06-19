class StatisticsController < ApplicationController
  helper_method :self_search
  before_filter :ensure_json_request, only: [:chart_data, :update_mail_data]
  before_action :authenticate_user!

  def index
    data_service = StatisticsDataService.new
    @data = data_service.period_views

    search_service = UpdateMailSearchService.new
    @latest_update_mails = search_service.search(params[:search], current_user, self_search)
                        .where('sent = true')
                        .order('update_mails.sent_at DESC')
                        .limit(10)
  end

  # Returns update mail related data as JSON
  def update_mail_data
    data_service = UpdateMailDataService.new(params[:id])
    render json: data_service.data
  end

  # Returns chart related Data as JSON
  def chart_data
    data_service = StatisticsDataService.new
    render json: data_service.chart_data(params[:id])
  end

end
