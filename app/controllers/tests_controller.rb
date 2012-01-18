class TestsController < ApplicationController
  before_filter :authenticate_user!
#  respond_to :html, :js
  # GET /tests
  # GET /tests.xml
  def index
    @tests = current_user.tests

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tests }
    end
  end

  # GET /tests/1
  # GET /tests/1.xml
  def show
    @test = Test.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /tests/new
  # GET /tests/new.xml
  def new
    @test = Test.new
    @test_categories = current_user.test_categories
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @test }
    end
  end

  # GET /tests/1/edit
  def edit
    @test = Test.find(params[:id])
    @test_categories = current_user.test_categories
  end

  # POST /tests
  # POST /tests.xml
  def create
    @test = Test.new(params[:test].merge(:user_id => current_user.id))
    respond_to do |format|
      if @test.save
        format.html { redirect_to(@test, :notice => 'Test was successfully created.') }
        format.xml  { render :xml => @test, :status => :created, :location => @test }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @test.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tests/1
  # PUT /tests/1.xml
  def update
    @test = Test.find(params[:id])
    respond_to do |format|
      if @test.update_attributes(params[:test])
        format.html { redirect_to(@test, :notice => 'Test was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @test.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tests/1
  # DELETE /tests/1.xml
  def destroy
    @test = Test.find(params[:id])
    @test.destroy

    respond_to do |format|
      format.html { redirect_to(tests_url) }
      format.xml  { head :ok }
    end
  end

end
