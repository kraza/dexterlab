class TestsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :redirect_to_account_page!
#  respond_to :html, :js
  # GET /tests
  # GET /tests.xml
  def index
    @current_page = (params[:page] || 1).to_i
    if params.include?('search_text')
      params[:search_text] = remove_special_character(params[:search_text])
      @tests = current_user.tests.paginate(:page => @current_page).search_by_test_name_test_code_category_name(params[:search_text])
    else
      @tests = current_user.tests.paginate(:page => @current_page).order_by_category_name
    end
    
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
      format.js # show.html.erb
    end
  end

  # GET /tests/new
  # GET /tests/new.xml
  def new
    @test = Test.new
    @test_categories = current_user.test_categories.where(:is_active => true)
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @test }
    end
  end

  # GET /tests/1/edit
  def edit
    @test = Test.find(params[:id])
    @test_categories = current_user.test_categories.where(:is_active => true)
  end

  # POST /tests
  # POST /tests.xml
  def create
    @test = Test.new(params[:test].merge(:user_id => current_user.id))
    respond_to do |format|
      if @test.save
        format.html { redirect_to(tests_url, :notice => 'Test was successfully created.') }
        format.xml  { render :xml => @test, :status => :created, :location => @test }
      else
        @test_categories = current_user.test_categories.where(:is_active => true)
        format.html { render :action => "new" }
        format.xml  { render :xml => @test.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tests/1
  # PUT /tests/1.xml
  def update
    @test = Test.find(params[:id])
    if params[:test].blank? #and params.include?(:is_active)
#     params.merge!({:doctor => {:is_active => params[:is_active]}})
      params[:test] = {}
      params[:test][:is_active] = !@test.is_active
    end
    respond_with(@test) do |format|
      if @test.update_attributes(params[:test])
        format.js
        format.html { redirect_to(tests_url, :notice => 'Test was successfully updated.') }
        format.xml  { head :ok }
      else
        @test_categories = current_user.test_categories.where(:is_active => true)
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
