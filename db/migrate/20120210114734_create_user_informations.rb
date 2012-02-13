class CreateUserInformations < ActiveRecord::Migration
  def self.up
    create_table :user_informations do |t|
      t.string :user_name
      t.string :salutation, :default => "Mr."
      t.string :first_name
      t.string :last_name
      t.string :category
      t.string :role
      t.text :address
      t.string :phone
      t.string :city
      t.string :state
      t.string :country
      t.string :zipcode
      t.boolean :is_active, :default => true
      t.boolean :is_registered, :default => false

      t.references :user

      t.timestamps
    end

    add_foreign_key :user_informations, :users
  end

  def self.down
    drop_table :user_informations
  end
end
