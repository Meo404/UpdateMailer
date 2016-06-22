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
      author: mail.user.email,
      createdAt: mail.created_at,
      sendAt: mail.sent_at,
      totalViews: mail.update_mail_views.count,
      viewsPerHour: records.group_by_hour_of_day(:created_at).count,
      viewsPerOS: records.group(:os).count,
      viewsPerDeviceType: records.group(:device_type).count}
  end

  private

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