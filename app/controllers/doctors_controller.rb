class DoctorsController < ApplicationController
  before_filter :authenticate_user!
  # GET /doctors
  # GET /doctors.xml
  def index
    @current_page = (params[:page] || 1).to_i
    @doctors = current_user.doctors.paginate( :page => @current_page )

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
      format.js if request.xhr?
      format.html # show.html.erb
      format.xml  { render :xml => @doctor }
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

    respond_to do |format|
      if @doctor.update_attributes(params[:doctor])
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
    @doctor = Doctor.find(params[:id])
    @doctors_patients = @doctor.patients
    @test_categories = current_user.test_categories
  end

end
