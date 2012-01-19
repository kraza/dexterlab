class TestCategoriesController < ApplicationController
  before_filter :authenticate_user!
  # GET /test_categories
  # GET /test_categories.xml
  def index
    @test_categories = current_user.test_categories

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @test_categories }
    end
  end

  # GET /test_categories/1
  # GET /test_categories/1.xml
  def show
    @test_category = TestCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @test_category }
    end
  end

  # GET /test_categories/new
  # GET /test_categories/new.xml
  def new
    @test_category = TestCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @test_category }
    end
  end

  # GET /test_categories/1/edit
  def edit
    @test_category = TestCategory.find(params[:id])
  end

  # POST /test_categories
  # POST /test_categories.xml
  def create
    @test_category = TestCategory.new(params[:test_category].merge(:user_id => current_user.id))

    respond_to do |format|
      if @test_category.save
        format.html { redirect_to(@test_category, :notice => 'Test category was successfully created.') }
        format.xml  { render :xml => @test_category, :status => :created, :location => @test_category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @test_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /test_categories/1
  # PUT /test_categories/1.xml
  def update
    @test_category = TestCategory.find(params[:id])

    respond_to do |format|
      if @test_category.update_attributes(params[:test_category])
        format.html { redirect_to(@test_category, :notice => 'Test category was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @test_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /test_categories/1
  # DELETE /test_categories/1.xml
  def destroy
    @test_category = TestCategory.find(params[:id])
    @test_category.destroy

    respond_to do |format|
      format.html { redirect_to(test_categories_url) }
      format.xml  { head :ok }
    end
  end

  #get list of all tests related to one test category,
  def tests
    unless params[:id] == "0"
      @tests = Test.where( :test_category_id => params[:id] )
      else
         @tests = current_user.tests
       end
    respond_to do |format|
      format.js
    end
  end
end

