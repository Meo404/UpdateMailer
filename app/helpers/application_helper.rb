module ApplicationHelper
  # Helper function to create sortable table column link
  # @param  column  column that should be sorted on
  # @param  title   title for the column. If nil the column name will be used
  # @return link
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to title, params.merge(sort: column, direction: direction, page: nil)
  end

  # Helper function to get the authors email address for a given update mail
  # returns 'Deleted User' if the user doesn't exist anymore
  def update_mail_author(update_mail)
    update_mail.user.nil? ? 'Deleted User' : update_mail.user.email
  end

  # Helper function to get the view count on any given update mail
  # @return   view count of the mail. Returns a hyphen if 0
  def view_count(update_mail)
    update_mail.update_mail_views_count > 0 ? update_mail.update_mail_views_count : '-'
  end
end
