class CreateDistributionLists < ActiveRecord::Migration
  def change
    create_table :distribution_lists do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
