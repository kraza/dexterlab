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
    @patient = Patient.new
    @doctors = current_user.doctors
    @test_categories = current_user.test_categories
    @tests = current_user.tests
    @cart = find_cart
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @patient }
    end
  end

  # GET /patients/1/edit
  def edit
    @doctors = current_user.doctors
    @patient = Patient.find(params[:id])
    
  end

  # POST /patients
  # POST /patients.xml
  def create
    params[:patient][:test_execution_date] = Date.strptime( params[:patient][:test_execution_date], "%m/%d/%Y" ) unless params[:patient][:test_execution_date].blank?
    params[:patient][:test_delivery_date] = Date.strptime( params[:patient][:test_delivery_date], "%m/%d/%Y" ) unless params[:patient][:test_delivery_date].blank?
    @patient = Patient.new(params[:patient].merge(:user_id => current_user.id))
    respond_to do |format|
      if @patient.save
        format.html { redirect_to(@patient, :notice => 'Patient was successfully created.') }
        format.xml  { render :xml => @patient, :status => :created, :location => @patient }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @patient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /patients/1
  # PUT /patients/1.xml
  def update
    @patient = Patient.find(params[:id])

    respond_to do |format|
      if @patient.update_attributes(params[:patient])
        format.html { redirect_to(@patient, :notice => 'Patient was successfully updated.') }
        format.xml  { head :ok }
      else
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
    unless @cart.test_ids.include?(parama[:id])
      @test = Test.find(params[:id])
      @cart.add_test(@test)
    end
    respond_to do |format|
      format.js
    end
  end
  
  #remove test from patient basket
  def remove_test
    @cart = find_cart
    @cart.clear_items(params[:id])
     respond_to do |format|
      format.js
    end
  end
  
  def find_cart
    session[:cart]  ||= Cart.new
  end

  private :find_cart
end
