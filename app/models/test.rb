class Test < ActiveRecord::Base
  belongs_to :test_category
  #attr_accessor :admin_test_category


  validates :fees, :commission_value, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :test_category_id, :code, :name, :commission_type, :presence => true
  validates :code, :uniqueness => true


#  def test_category
#    @admin_test_category = Admin::TestCategory.find(self.category_id)
#  end

  def comission_value
    if self.commission_type == "percentage"
      "#{self.commission_value.to_i}  %"
    else
      self.commission_value
    end
  end
end
