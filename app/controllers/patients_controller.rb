class PatientsController < ApplicationController
  before_filter :authenticate_user!
  # GET /patients
  # GET /patients.xml
  def index
    @patients =  current_user.patients

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @patients }
    end
  end

  # GET /patients/1
  # GET /patients/1.xml
  def show
    @patient = Patient.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @patient }
    end
  end

  # GET /patients/new
  # GET /patients/new.xml
  def new
    @cart = find_cart
    @patient = Patient.new
    @patient.refrence_no = @patient.reference_number
    @patient.total_amount = @cart.total_amount
    doctor_test_category_test_values
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @patient }
    end
  end

  # GET /patients/1/edit
  def edit

    doctor_test_category_test_values
    @patient = Patient.find(params[:id])
    @patient.test_execution_date = date_format(@patient.test_execution_date)
    @patient.test_delivery_date = date_format(@patient.test_delivery_date)
    @cart = find_cart(@patient.id)
    @cart.edit_patient_tests(@patient)

  end

  # POST /patients
  # POST /patients.xml
  def create
    params[:patient][:test_delivery_date] = Date.strptime( params[:patient][:test_delivery_date], "%d/%m/%Y" ) unless params[:patient][:test_delivery_date].blank?
    params[:patient][:test_execution_date] = Date.strptime( params[:patient][:test_execution_date], "%d/%m/%Y" ) unless params[:patient][:test_execution_date].blank?
    @patient = Patient.new(params[:patient].merge(:user_id => current_user.id))
    @cart = find_cart
    @patient.add_line_tests_from_cart(@cart)
    respond_to do |format|
      if @patient.save
        kill_session
        format.html { redirect_to(@patient, :notice => 'Patient was successfully created.') }
        format.xml  { render :xml => @patient, :status => :created, :location => @patient }
      else
        doctor_test_category_test_values
        format.html { render :action => "new" }
        format.xml  { render :xml => @patient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /patients/1
  # PUT /patients/1.xml
  def update
    @patient = Patient.find(params[:id])
    params[:patient][:test_execution_date] = Date.strptime( params[:patient][:test_execution_date], "%d/%m/%Y" )
    params[:patient][:test_delivery_date] = Date.strptime( params[:patient][:test_delivery_date], "%d/%m/%Y" )

    @cart = find_cart(@patient.id)
    @patient.add_line_tests_from_cart(@cart)

    kill_session(@patient.id)
    respond_to do |format|
      if @patient.update_attributes(params[:patient])
        format.html { redirect_to(@patient, :notice => 'Patient was successfully updated.') }
        format.xml  { head :ok }
      else
        doctor_test_category_test_values
        format.html { render :action => "edit" }
        format.xml  { render :xml => @patient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.xml
  def destroy
    @patient = Patient.find(params[:id])
    @patient.destroy

    respond_to do |format|
      format.html { redirect_to(patients_url) }
      format.xml  { head :ok }
    end
  end

  #Add test for patient test basket
  def add_test
    #@cart.items.each{
    @cart = find_cart
    unless @cart.test_ids.include?(params[:id].to_i)
      @test = Test.find(params[:id])
      @cart.add_test(@test)
    else
      @test = []
    end
    respond_to do |format|
      format.js
    end
  end

  #remove test from patient basket
  def remove_test
    @cart = find_cart
    @cart.reset_cart(params[:id], params[:s_no])
    respond_to do |format|
      format.js
    end
  end

  #create catt session is not present
  def find_cart(id= "new")
    session["cart_#{id}".to_sym]  ||= Cart.new
  end

  #Destroy cart session is present
  def kill_session(id="new")
    session["cart_#{id}".to_sym] = nil
  end

  def doctor_test_category_test_values
    @doctors = current_user.doctors
    @test_categories = current_user.test_categories
    @tests = current_user.tests
  end

  private :find_cart, :doctor_test_category_test_values
end
