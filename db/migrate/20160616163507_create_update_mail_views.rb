class CreateUpdateMailViews < ActiveRecord::Migration
  def change
    create_table :update_mail_views do |t|
      t.references :update_mail, index: true, foreign_key: true
      t.string :ip
      t.string :user_agent
      t.string :browser
      t.string :browser_version
      t.string :os
      t.string :os_version
      t.string :device_name
      t.string :device_type

      t.timestamps null: false
    end
  end
end
