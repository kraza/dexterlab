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
    total_doctors_commission - total_paid_doctors_commission
  end
end
