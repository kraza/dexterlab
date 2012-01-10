class CreateTestCategories < ActiveRecord::Migration
  def self.up
    create_table :test_categories do |t|
      t.string :name
      t.text :description
      t.boolean :is_active, :default => true
      t.references :user
      t.timestamps
    end
    add_foreign_key :test_categories, :users
  end

  def self.down
    drop_table :test_categories
  end
end
