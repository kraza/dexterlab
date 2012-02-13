class UserInformation < ActiveRecord::Base

  belongs_to :user

  validates :user_name, :first_name, :last_name, :address, :phone, :city, :state, :country, :zipcode, :presence => true, :on => :update
  validates :user_name, :uniqueness => true, :on => :update

  before_update :is_registered_true!, :unless  => "self.is_registered?"

  #On update set is_registered as true
  def is_registered_true!
    self.is_registered = true
  end
  
end
