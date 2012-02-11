class WelcomeController < ApplicationController
  def index
  end

  def home
    @total_active_test_category = current_user.test_categories.where(:is_active => true).count
    @total_inactive_test_category = current_user.test_categories.where(:is_active => false).count
    @total_active_test = current_user.tests.where(:is_active => true).count
    @total_inactive_test = current_user.tests.where(:is_active => false).count
    @total_active_doctor = current_user.doctors.where(:is_active => true).count
    @total_inactive_doctor = current_user.doctors.where(:is_active => false).count
    @total_patient_count = current_user.patients.count
    @total_income = current_user.total_payment_received_from_patient
  end
end
