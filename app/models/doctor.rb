class Doctor < ActiveRecord::Base
  belongs_to :user
  has_many :patients
  has_many :line_tests

  before_destroy :check_line_tests
  after_save :set_doc_code, :if => "code.empty?"
  validates  :first_name, :designation, :cell, :presence => true
  validates :email,   :presence => true,  :uniqueness => true, :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
 validates :code, :uniqueness => true, :unless  => "code.empty?"

  def name
    "#{self.first_name} #{last_name}"
  end


  def set_doc_code
    self.code = self.first_name[0..2].upcase+"-"+Date.today.year.to_s+"-"+self.id.to_s
    self.send("code=", self.code)
    self.save #if code.empty?
  end

  #check linetest before destroy
  def check_line_tests
    false if self.line_tests.size > 0
  end
end
