class AddIsActiveToDoctors < ActiveRecord::Migration
  def self.up
    add_column :doctors, :is_active, :boolean
  end

  def self.down
    remove_column :doctors, :is_active, :default => true
  end
end
