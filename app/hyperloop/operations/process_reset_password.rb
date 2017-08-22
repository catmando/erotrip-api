class ProcessResetPassword < Hyperloop::ServerOp
  param :email, default: nil, nils: true
  param :pin, default: nil, nils: true
  param :password, default: nil, nils: true
  param :password_confirmation, default: nil, nils: true
  param :acting_user, default: nil, nils: true

  [:email, :pin, :password, :password_confirmation].each do |field|
    add_error field, :blank, "nie może być puste" do
      params.try(field).blank?
    end
  end

  failed do |exception|
    exception.errors.message
  end
  step do
    User.where(email: params.email, pin: params.pin)
  end
  step do |user|
    fail if user.first.blank?
    user.first
  end
  failed do |exception|
    if exception.is_a?(Hash)
      exception
    else
      { base: 'Podałeś/aś niepoprawny e-mail lub PIN' }
    end
  end
  step do |user|
    user.password = params.password
    {status: user.save, user: user}
  end
  step do |response|
    unless response[:status]
      raise ArgumentError, response[:user].errors.messages.to_json
    end
    response[:user]
  end
  failed do |exception|
    if exception.is_a?(Hash)
      exception
    else
      err = { base: 'Nie udało się zrestartować hasła' }
      err = err.deep_merge(JSON.parse(exception.message.gsub('=>', ':')))
      err
    end
  end
end