class ReportsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :redirect_to_account_page!

  def index
    patients_month = current_user.patients.group("month(created_at)").count

    patients = current_user.patients.all
    tests = current_user.line_tests.all
    test_month_array = tests.group_by{|t| t.created_at.strftime("%B")}.collect{|k,v|  [k,v.count]}.flatten
    patient_month_array = patients.group_by{|t| t.created_at.strftime("%B")}.collect{|k,v|  [k,v.count]}.flatten
    db_patient_month_hash = Hash[*patient_month_array]
    db_test_month_hash = Hash[*test_month_array]
    months = Date::MONTHNAMES.compact

    @month_names = Date::MONTHNAMES.compact
    month_list_hash = @month_names.to_hash_keys{|v| 0}
    @month_patient_hash = month_list_hash.merge(db_patient_month_hash)
    @month_test_hash = month_list_hash.merge(db_test_month_hash)
  end

  def patient
  end

  def testvspatient
    @test_patients = current_user.line_tests.group(:test_id).count
    @tests_name = @test_patients.keys.collect{|i| Test.find(i).code.upcase + "/ "+Test.find(i).name.upcase}
  end

  def doctorvstest
    @doctors_tests = current_user.line_tests.group(:doctor_id).count
    @doctors_name = @doctors_tests.keys.collect{|i| Doctor.find(i).name.titleize}
  end

  def doctorvspatient
    @doctors_patients = current_user.patients.group(:doctor_id).count
    @doctors_name = @doctors_patients.keys.collect{|i| Doctor.find(i).name.titleize}
  end

end
