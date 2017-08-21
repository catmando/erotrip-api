class ProcessRegistration < Hyperloop::Operation
  param :kind, type: String
  param terms_acceptation: false, type: Boolean
  param :name, type: String
  param :birth_year, type: Integer
  # param name_second_person: nil, type: String
  # param birth_year_second_person: 0, type: Integer
  param :email, type: String
  param :city, type: String
  param :password, type: String
  param :password_confirmation, type: String
  param :pin, type: Integer
  param :pin_confirmation, type: Integer

  add_error :kind, :blank, "nie może być puste" do
    params.kind.blank?
  end

  add_error :name, :blank, "nie może być puste" do
    params.name.blank?
  end

  add_error :birth_year, :blank, "nie może być puste" do
    params.birth_year.blank?
  end

  # add_error :name_second_person, :blank, "nie może być puste" do
  #   params.name_second_person.blank? && params.kind.present? && !['man', 'woman'].include?(params.kind)
  # end

  # add_error :birth_year_second_person, :blank, "nie może być puste" do
  #   params.birth_year_second_person.blank? && params.kind.present? && !['man', 'woman'].include?(params.kind)
  # end

  add_error :email, :blank, "nie może być puste" do
    params.email.blank?
  end

  add_error :city, :blank, "nie może być puste" do
    params.city.blank?
  end

  add_error :password, :blank, "nie może być puste" do
    params.password.blank?
  end

  add_error :password_confirmation, :blank, "nie może być puste" do
    params.password_confirmation.blank?
  end

  add_error :password_confirmation, :same_as, "hasła nie są takie same" do
    params.password != params.password_confirmation
  end

  add_error :pin, :blank, "nie może być puste" do
    params.pin.blank?
  end

  add_error :pin_confirmation, :blank, "nie może być puste" do
    params.pin_confirmation.blank?
  end

  add_error :pin_confirmation, :same_as, "PINy nie są takie same" do
    params.pin != params.pin_confirmation
  end

  add_error :terms_acceptation, :blank, "musi zostać zaakceptowane" do
    !params.terms_acceptation
  end

  step do
    HTTP.post('/users.json', payload: { user: {
      kind: params.kind,
      name: params.name,
      birth_year: params.birth_year,
      # name_second_person: params.name_second_person,
      # birth_year_second_person: params.birth_year_second_person,
      email: params.email,
      city: params.city,
      password: params.password,
      password_confirmation: params.password_confirmation,
      pin: params.pin,
      pin_confirmation: params.pin_confirmation,
      terms_acceptation: params.terms_acceptation
    } } )
  end
  step do |response|
    puts 'ZAREJESTROWANO!'
    puts response.json
    # CurrentUserStore.current_user_id! response.json['user']['id']
    response
  end
  # failed do |response|
  #   puts 'NIE POSZLO W OPERACJI'
  #   puts JSON.parse(response.body).inspect
  #   # {data: JSON.parse(response.body)}
  #   # Object.new({data: JSON.parse(response.body)})
  #   response
  # end
end