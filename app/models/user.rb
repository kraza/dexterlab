class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_many :doctors
  has_many :patients
  has_many :test_categories
  has_many :tests
  has_many :line_tests
  has_one :user_information, :dependent => :destroy

  before_create :create_user_information


  #Create user information entry
  def create_user_information
    self.user_information = UserInformation.new
  end

  #This method calculates payment received from patient.
  def total_payment_received_from_patient
    patients.compact.inject(0){|sum,patient| (sum + patient.total_amount)}
  end

  #This method calculates payment received from patient during time of reference.
  def total_payment_received_from_patient_by_doctor
    patients.collect{|patient| patient if patient.is_recived_payment_by_doctor?}.compact.inject(0){|sum,patient| (sum + patient.total_amount)}
  end

  #Calculate total doctors commiaaion
  def total_doctors_commission
    doctors.collect.inject(0){|sum,doctor| (sum + doctor.total_commission)}
  end

  #calculate paid doctors commission
  def total_paid_doctors_commission_by_lab
    doctors.collect.inject(0){|sum,doctor| (sum + doctor.total_paid_commission_by_lab)}
  end

  #calculate some of all doctors payment
  def total_paid_doctors_commission
    total_paid_doctors_commission_by_lab + total_payment_received_from_patient_by_doctor
  end

  #Calculate total dues doctors commission
  def total_dues_doctors_commission
    total_dues = total_doctors_commission - total_paid_doctors_commission
    if total_dues > 0
      return total_dues
    else
      return "#{- total_dues} (Advance)"
    end
  end
  
# Find all active tests for currently logged in user
  def active_tests
    tests.active
  end

  # Find all active doctors for currently logged in user
  def active_doctors
    doctors.active
  end

# Find all active test categories for currently logged in user
  def active_test_categories
    test_categories.active
  end

  def patient_position
    # Find all active doctors for currently logged in user
    patients.where("created_at >=?", Date.today ).count.to_i
  end

end
