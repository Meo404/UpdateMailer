class UpdateMailDataService
  def initialize(id)
    @update_mail_id = id
  end

  # Method to gather all necessary information to be displayed on the update mail statistics
  # Includes:
  # - Views splitted by day for the last 2 weeks
  # - Views splitted by hour of the day
  # - Views splitted by operating system
  # - Views splitted by device type
  #
  # @return   hash of previous mentioned statistics
  def data
    mail = UpdateMail.find(@update_mail_id)
    records = UpdateMailView.where('update_mail_id = ?', @update_mail_id)
    { updateMailId: @update_mail_id,
      title: mail.title,
      createdAt: mail.created_at,
      sendAt: mail.sent_at,
      totalViews: mail.update_mail_views.count,
      viewsPerDay: (two_week_days.merge! records.group('date(created_at)').count),
      viewsPerHour: records.group_by_hour_of_day(:created_at).count,
      viewsPerOS: records.group(:os).count,
      viewsPerDeviceType: refine_device_types(records.group(:device_type).count)}
  end

  private

  # Combines smartphone, tablet and phablet views into one category named 'mobile'
  # @return  refined views per device type
  def refine_device_types(result)
    result.merge!(mobile: result.values_at('smartphone', 'tablet', 'phablet').sum)
          .except!('smartphone', 'tablet', 'phablet')
  end

  # Returns all dates within the last 14 days
  # @return   days
  def two_week_days
    date_counts = {}
    (13.days.ago.to_date..0.day.ago.to_date).each do |date|
      date_counts[date]=0
    end
    date_counts
  end
end