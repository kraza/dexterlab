class Doctor < ActiveRecord::Base
  has_many :patients

  validates :code, :first_name, :designation, :cell, :presence => true
  validates :email,   :presence => true,  :uniqueness => true, :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
end
