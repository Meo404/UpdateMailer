class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :emails, :distribution_lists do |t|
      t.index [:email_id, :distribution_list_id], name: :idx_email_distribution_list
      t.index [:distribution_list_id, :email_id], name: :idx_distribution_list_email
    end
  end
end
