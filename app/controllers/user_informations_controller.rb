class UserInformationsController < ApplicationController

  before_filter :authenticate_user!
  
  
  def edit
    @user_information = current_user.user_information
  end

  def update
    @user_information = current_user.user_information
#    if @user_information.update_attributes(params[:user_information])
#      notice = 'Account was successfully updated.'
#      redirect_to(root_url, :notice => notice)
#    else
#      notice = @user_information.errors
#      redirect_to(account_url, :notice => notice)
#    end

    respond_to do |format|
      if @user_information.update_attributes(params[:account])
        format.html { redirect_to(root_url, :notice => 'Account was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html {  render :action => "edit"  }
        format.xml  { render :xml => @user_information.errors, :status => :unprocessable_entity }
      end
    end
  end

end
