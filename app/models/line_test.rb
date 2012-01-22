class LineTest < ActiveRecord::Base
  belongs_to :user
  belongs_to :test
  belongs_to :doctor
  belongs_to :patient
  belongs_to :test_category

  def self.from_cart_item(cart_item, doctor_id, user_id)
    li = self.new
    li.test_id = cart_item.id
    li.user_id = user_id
    li.test_fee = cart_item.fees
    li.doctor_id = doctor_id
    li.test_category_id = cart_item.test_category_id
    li.doctors_commission = cart_item.doctor_commission
    li
  end

end
