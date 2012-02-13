class PatientsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :redirect_to_account_page!
  before_filter :find_cart, :only => [:new, :edit, :create, :update, :add_test, :remove_test]
  # GET /patients
  # GET /patients.xml
  def index
    @current_page = (params[:page] || 1).to_i
    
    if params.include?('search_text')
      params[:search_text] = remove_special_character(params[:search_text])
      @patients = current_user.patients.paginate(:page => @current_page).search_first_name_last_name_ref_no(params[:search_text])
    else
      @patients =  current_user.patients.paginate(:page => @current_page).order('created_at DESC')
    end
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
      format.js if request.xhr?
      format.html # show.html.erb
      format.xml  { render :xml => @patient }
    end
  end

  # GET /patients/new
  # GET /patients/new.xml
  def new
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
    #@cart = find_cart(@patient.id)
    @cart.edit_patient_tests(@patient)

  end

  # POST /patients
  # POST /patients.xml
  def create
    params[:patient][:test_delivery_date] = Date.strptime( params[:patient][:test_delivery_date], "%d/%m/%Y" ) unless params[:patient][:test_delivery_date].blank?
    params[:patient][:test_execution_date] = Date.strptime( params[:patient][:test_execution_date], "%d/%m/%Y" ) unless params[:patient][:test_execution_date].blank?
    @patient = Patient.new(params[:patient].merge(:user_id => current_user.id))
    #@cart = find_cart
    @patient.add_line_tests_from_cart(@cart)
    respond_to do |format|
      if @patient.save
        kill_session
        format.html { redirect_to(patients_url, :notice => 'Patient was successfully created.') }
        format.xml  { render :xml => @patient, :status => :created, :location => @patient }
      else
        doctor_test_category_test_values
        @patient.test_execution_date = date_format(@patient.test_execution_date) unless params[:patient][:test_execution_date].blank?
        @patient.test_delivery_date = date_format(@patient.test_delivery_date) unless params[:patient][:test_delivery_date].blank?
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

    @patient.add_line_tests_from_cart(@cart)
    kill_session(@patient.id)
    respond_to do |format|
      if @patient.update_attributes(params[:patient])
        format.html { redirect_to(patients_url, :notice => 'Patient was successfully updated.') }
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
    #@cart = find_cart(params[:patient_id])
    @cart.reset_cart(params[:id], params[:s_no])
    respond_to do |format|
      format.js
    end
  end

  #This method use to take print format for patient's prescription
  def prescription_print
    @patient = Patient.find(params[:id])
    respond_to do |format|
      format.js if request.xhr?
      format.html # show.html.erb
      format.xml  { render :xml => @patient }
    end
  end

  #create catt session is not present
  def find_cart(id= "new")
      # create session with cart_new for new patient and
      # Session cart_parient.id for edit
    if action_name == 'add_test' or action_name == 'remove_test'
      last_http_referer = request.env['HTTP_REFERER'].split('/').last
    else
      last_http_referer = action_name
    end

    if action_name == 'new' or last_http_referer == 'new'
      id = 'new'
    elsif action_name == 'edit' or last_http_referer == 'patients'
      id = params[:id]
    else
      id = request.env['HTTP_REFERER'].split('/')[4]
    end

    session["cart_#{id}".to_sym]  ||= Cart.new
    @cart = session["cart_#{id}".to_sym]
#    session["cart"]  ||= Cart.new
#    @cart = session["cart"]
  end

  #Destroy cart session is present
  def kill_session(id="new")
    session["cart_new"] = nil
    session["cart_#{id}".to_sym] = nil
  end

  def doctor_test_category_test_values
    @doctors = current_user.doctors
    @test_categories = current_user.test_categories.where(:is_active => true)
    @tests = current_user.tests.where(:is_active => true)
  end

  private :find_cart, :kill_session, :doctor_test_category_test_values
end
