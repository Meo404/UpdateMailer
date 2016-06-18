class CreateUpdateMails < ActiveRecord::Migration
  def change
    create_table :update_mails do |t|
      t.string :title
      t.text :body
      t.string :permalink
      t.boolean :sent
      t.datetime :sent_at, default: nil
      t.boolean :public, default: false

      t.timestamps null: false
    end
  end
end
