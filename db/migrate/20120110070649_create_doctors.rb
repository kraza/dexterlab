class CreateDoctors < ActiveRecord::Migration
  def self.up
    create_table :doctors do |t|
      t.string :code
      t.string :first_name
      t.string :last_name
      t.string :designation
      t.string:email
      t.string :cell
      t.string :phone
      t.string :address1
      t.string :address2
      t.string :postal
      t.string :city
      t.string :state
      t.references :user
      t.timestamps
    end
    add_foreign_key :doctors, :users
  end

  def self.down
    drop_table :doctors
  end
end
