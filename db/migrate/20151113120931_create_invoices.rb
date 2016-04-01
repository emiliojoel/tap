class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :amount, :limit => 20
      t.text :desc
      t.datetime :date
      t.string :status, :limit => 10
      t.timestamps null: false
    end
  end
end
