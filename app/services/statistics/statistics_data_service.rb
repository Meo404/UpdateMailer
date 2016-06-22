# Service Class to retrieves statistical UpdateMail Data
class StatisticsDataService
  # Method to retrieve Update Mail Views for a given time period
  # @return   Array of Hashes with views for each day
  def chart_data(update_mail_id = false)
    data = view_counts(update_mail_id)
    total_views = Hash[data.map { |h| h.values_at('date', 'total_views') }]
    desktop_views = Hash[data.map { |h| h.values_at('date', 'desktop_views') }]
    mobile_views = Hash[data.map { |h| h.values_at('date', 'mobile_views') }]
    tablet_views = Hash[data.map { |h| h.values_at('date', 'tablet_views') }]
    other_views = Hash[data.map { |h| h.values_at('date', 'other_views') }]

    (13.days.ago.to_date.strftime('%F')..0.day.ago.to_date.strftime('%F')).map do |date|
      {date: date,
       viewsPerDeviceType: {
        totalViews: total_views[date] || 0,
        desktopViews: desktop_views[date] || 0,
        mobileViews: mobile_views[date] || 0,
        tabletViews: tablet_views[date] || 0,
        otherViews: other_views[date] || 0,
      }}
    end
  end

  # Method to retrieve mail creations and views
  # Periods: Last Month & All time
  # @return   Hash containing period creations/views
  def period_views
    @data = {
      all_time_views: UpdateMailView.count,
      last_month_views: UpdateMailView.where('created_at >= ?', 1.month.ago).count,
      all_time_mails: UpdateMail.where('sent = true').count,
      last_month_mails: UpdateMail.where('sent_at >= ?', 1.month.ago).count
    }
  end

  private

  # Method to query traffic stats from the Database (last 2 weeks).
  # Includes total views and views per device type.
  # An update mail id can be provided to only retrieve the stats for the specific update mail
  # @param  update_mail_id  id of an update mail
  # @return hash of results
  def view_counts(update_mail_id)
    if update_mail_id
      UpdateMailView.connection.select_all("
      select to_char(date_trunc('day', created_at), 'YYYY-MM-DD') as date,
        count(*) as total_views,
        count(*) filter (where device_type = 'desktop') as desktop_views,
        count(*) filter (where device_type = 'mobile') as mobile_views,
        count(*) filter (where device_type = 'tablet') as tablet_views,
        count(*) filter (where device_type = 'other') as other_views
      from update_mail_views
      where update_mail_id = #{update_mail_id}
      and created_at >= '#{2.weeks.ago.to_date.strftime('%F')}'
      GROUP BY date
      ORDER BY date desc").to_hash
    else
      UpdateMailView.connection.select_all("
      select to_char(date_trunc('day', created_at), 'YYYY-MM-DD') as date,
        count(*) as total_views,
        count(*) filter (where device_type = 'desktop') as desktop_views,
        count(*) filter (where device_type = 'mobile') as mobile_views,
        count(*) filter (where device_type = 'tablet') as tablet_views,
        count(*) filter (where device_type = 'other') as other_views
      from update_mail_views
      where created_at >= '#{2.weeks.ago.to_date.strftime('%F')}'
      GROUP BY date
      ORDER BY date desc").to_hash
    end
  end
end
