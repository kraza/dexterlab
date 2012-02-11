class LoggedInConstraint < Struct.new(:value)

  def matches?(request)
    request.env["rack.session"].key?("warden.user.user.key") == value
  end

end