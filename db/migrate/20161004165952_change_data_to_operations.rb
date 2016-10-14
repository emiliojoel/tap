class ChangeDataToOperations < ActiveRecord::Migration
  def change
  change_column :operations, :data, :text
  end
end
