class AddUserIdToUpdateMails < ActiveRecord::Migration
  def change
    add_column :update_mails, :user_id, :integer
  end
end
