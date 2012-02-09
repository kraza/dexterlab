class DoctorsController < ApplicationController

  require 'csv'
  before_filter :authenticate_user!
  # GET /doctors
  # GET /doctors.xml
  def index
    @current_page = (params[:page] || 1).to_i
    @doctors = current_user.doctors.paginate( :page => @current_page ).order_by_code_asc

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @doctors }
    end
  end

  # GET /doctors/1
  # GET /doctors/1.xml
  def show
    @doctor = Doctor.find(params[:id])

    respond_to do |format|
      format.js
      format.html { redirect_to(doctors_url) }
    end

  end

  # GET /doctors/new
  # GET /doctors/new.xml
  def new
    @doctor = Doctor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @doctor }
    end
  end

  # GET /doctors/1/edit
  def edit
    @doctor = Doctor.find(params[:id])
  end

  # POST /doctors
  # POST /doctors.xml
  def create
    @doctor = Doctor.new(params[:doctor].merge(:user_id => current_user.id))
    respond_to do |format|
      if @doctor.save
        format.html { redirect_to(doctors_url, :notice => 'Doctor was successfully created.') }
        format.xml  { render :xml => @doctors_url, :status => :created, :location => @doctor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @doctor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /doctors/1
  # PUT /doctors/1.xml
  def update
    @doctor = Doctor.find(params[:id])
    if params[:doctor].blank? #and params.include?(:is_active)
#      params.merge!({:doctor => {:is_active => params[:is_active]}})
      params[:doctor] = {}
      params[:doctor][:is_active] = !@doctor.is_active
    end
    respond_with(@doctor) do |format|
      if @doctor.update_attributes(params[:doctor])
        format.js
        format.html { redirect_to(doctors_url, :notice => 'Doctor was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @doctor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /doctors/1
  # DELETE /doctors/1.xml
  def destroy
    @doctor = Doctor.find(params[:id])
    @doctor.destroy

    respond_to do |format|
      format.html { redirect_to(doctors_url) }
      format.xml  { head :ok }
    end

  end


  # GET PATIENT_LIST /doctors/:id/patients_list
  # This method display list of all patients and tests .
  def patients_list
    @to_date = (params.key?(:search)  and !params[:search][:to_date].blank?) ? params[:search][:to_date] : ""
    @from_date =   (params.key?(:search)  and !params[:search][:from_date].blank?) ? params[:search][:from_date] : ""
    @current_page = (params[:page] || 1).to_i
    @doctor = Doctor.find(params[:id])
    if params.key?(:search) and !@to_date.blank? and !@from_date.blank?
      @doctors_patients = @doctor.patients.paginate( :page => @current_page).order_by_test_date_with_range(date_strip(@to_date),date_strip(@from_date))
    else
      @doctors_patients = @doctor.patients.paginate( :page => @current_page).order_by_test_date_with_out_range
    end
    @test_categories = current_user.test_categories
  end

  # This method display payment history and all will do all payment related events.
  def account
    @doctor = Doctor.find(params[:id])
    @accounts = @doctor.accounts
    respond_to do |format|
      format.html
    end
  end

  #Method For Open payment popup.
  def payment
    @doctor = Doctor.find(params[:id])
    @account = Account.new(:dues_amount => @doctor.total_dues_commission)
    respond_to do |format|
      format.js
    end

  end

  #Method for made paymet
  def make_payment
    params[:account][:dues_amount] = - params[:account][:dues_amount].to_f if params[:account][:dues_amount].include?("Advance")
    @account = Account.new(params[:account].merge(:user_id => current_user.id, :doctor_id => params[:id]))
    @count = Doctor.find(params[:id]).accounts.count
    respond_to do |format|
      if @account.save
        format.js
      else
        format.js {render :payment}
      end
    end
  end

  # GET /export_to_csv
  # Export listed subnet reservations to a CSV file
  def export_to_csv
    to_date =  params[:to_date]
    from_date =  params[:from_date]
    @doctor = Doctor.find(params[:id])
    test_categories = current_user.test_categories
     if  !to_date.blank? and !from_date.blank?
      @doctors_patients = @doctor.patients.order_by_test_date_with_range(date_strip(to_date),date_strip(from_date))
    else
      @doctors_patients = @doctor.patients.order_by_test_date_with_out_range
    end
    test_category_name =  test_categories.collect{|test_category| test_category.name}
    header =  Patient::PATIENT_LIST_HEADERS1 + test_category_name + Patient::PATIENT_LIST_HEADERS2
    patients_csv_string = CSV.generate do |csv|
      # Find this definition in application_constants.rb
      csv << header
      @doctors_patients.each do |patient|
        temp_array = [patient.test_execution_date, patient.full_name, patient.test_names]
        test_categories.each do |test_category|
          temp_array << patient.sum_of_test_fee_based_on_category[test_category.id.to_s]
        end
        temp_array = temp_array  + [  patient.total_amount, patient.sum_of_doctor_commission, patient.doctor_received_paymet]
        csv << temp_array
      end
    end
    # Send_data for download
    filename = I18n.l(Time.now, :format => :short) + "- patients_list.csv"
    send_data( patients_csv_string,
      :type => 'text/csv; charset=utf-8; header=present',
      :filename =>filename )
  end # export_to_csv

end
