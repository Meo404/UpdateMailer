class StatisticsController < ApplicationController
  def index
    data_service = StatisticsDataService.new
    @data = data_service.period_views
  end

  # Returns chart related Data as JSON
  def chart_data
    data_service = StatisticsDataService.new
    render json: data_service.chart_data
  end
end
