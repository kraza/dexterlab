class Doctor < ActiveRecord::Base
  belongs_to :user
  has_many :patients
  has_many :line_tests

  validates :code, :first_name, :designation, :cell, :presence => true
  validates :email,   :presence => true,  :uniqueness => true, :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }


  def name
    "#{self.first_name} #{last_name}"
  end

end
