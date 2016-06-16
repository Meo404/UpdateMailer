class AddViewsCountToUpdateMails < ActiveRecord::Migration
  def change
    add_column :update_mails, :update_mail_views_count, :integer, default: 0
  end
end
