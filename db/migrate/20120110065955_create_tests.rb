class CreateTests < ActiveRecord::Migration
  def self.up
    create_table :tests do |t|
      t.string :code
      t.string :name
      t.decimal :fees, :precision => 6, :scale => 2
      t.string :commission_type
      t.decimal :commission_value, :precision => 6, :scale => 2
      t.text :description
      t.boolean :is_active, :default => true
      t.references :user
      t.references :test_category
      t.timestamps
    end
    add_foreign_key :tests, :users
    add_foreign_key :tests, :test_categories
  end

  def self.down
    drop_table :tests
  end
end
