class CreateOperations < ActiveRecord::Migration
  def change
    create_table :operations do |t|
      t.string :event
      t.string :api_version
      t.string :account_id
      t.string :signature
      t.string :data

      t.timestamps null: false
    end
  end
end
