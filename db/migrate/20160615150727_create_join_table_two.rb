class CreateJoinTableTwo < ActiveRecord::Migration
  def change
    create_join_table :update_mails, :distribution_lists do |t|
      t.index [:update_mail_id, :distribution_list_id], name: :idx_update_mail_distribution_list
      t.index [:distribution_list_id, :update_mail_id], name: :idx_distribution_list_update_mail
    end
  end
end
