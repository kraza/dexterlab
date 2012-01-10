class CreatePatients < ActiveRecord::Migration
  def self.up
    create_table :patients do |t|
      t.string :refrence_no
      t.string :initial_name
      t.string :first_name
      t.string :last_name
      t.date :test_execution_date
      t.date :test_delivery_date
      t.decimal :total_amount, :precision => 6, :scale => 2
      t.decimal :advance_payment, :precision => 6, :scale => 2
      t.boolean :is_doctor_receoved_payment
      t.references :doctor
      t.references :user
      t.timestamps
    end
    add_foreign_key :patients, :doctors
    add_foreign_key :patients, :users
  end

  def self.down
    drop_table :patients
  end
end
