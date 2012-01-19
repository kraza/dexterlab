class CreateLineTests < ActiveRecord::Migration
  def self.up
    create_table :line_tests do |t|

      t.decimal :test_fee, :precision => 6, :scale => 2
      t.decimal :doctors_commission, :precision => 6, :scale => 2

      t.references :test
      t.references :patient
      t.references :test_category

      t.timestamps
    end

      add_foreign_key :line_tests, :tests
      add_foreign_key :line_tests, :patients
      add_foreign_key :line_tests, :test_categories
  end

  def self.down
    drop_table :line_tests
  end
end
