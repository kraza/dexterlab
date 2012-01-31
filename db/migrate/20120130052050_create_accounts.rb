class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.decimal :paid_amount, :precision => 6, :scale => 2
      t.decimal :dues_amount, :precision => 6, :scale => 2

      t.references :user
      t.references :doctor

      t.timestamps
    end

    add_foreign_key :accounts,  :users
    add_foreign_key :accounts,  :doctors
    
  end

  def self.down
    drop_table :accounts
  end
end
