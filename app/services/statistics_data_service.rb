# Service Class to retrieves statistical UpdateMail Data
class StatisticsDataService
  # Method to retrieve Update Mail Views for a given time period
  # @return   Array of Hashes with views for each day
  def chart_data
    data = view_counts
    total_views = Hash[data.map { |h| h.values_at('date', 'total_views') }]
    mobile_views = Hash[data.map { |h| h.values_at('date', 'mobile_views') }]
    desktop_views = Hash[data.map { |h| h.values_at('date', 'desktop_views') }]

    @views_per_day = (6.days.ago.to_date.strftime('%F')..0.day.ago.to_date.strftime('%F')).map do |date|
      {
        date: date,
        total_views: total_views[date] || 0,
        mobile_views: mobile_views[date] || 0,
        desktop_views: desktop_views[date] || 0
      }
    end
  end

  def period_views
    @data = {
      all_time_views: UpdateMailView.count,
      last_month_views: UpdateMailView.where('created_at >= ?', 1.month.ago).count,
      all_time_mails: UpdateMail.where('sent = true').count,
      last_month_mails: UpdateMail.where('sent_at >= ?', 1.month.ago).count
    }
  end

  private

  # Method to query traffic stats from the Database
  def view_counts
    UpdateMailView.connection.select_all("
      select to_char(date_trunc('day', created_at), 'YYYY-MM-DD') as date,
        count(*) as total_views, count(*) filter (where device_type = 'desktop') as desktop_views,
        count(*) filter (where device_type != 'desktop') as mobile_views
      from update_mail_views
      GROUP BY date
      ORDER BY date desc").to_hash
  end
end
