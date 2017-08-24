class ProcessRegistration < Hyperloop::Operation
  param :kind
  param terms_acceptation: false
  param :name
  param :birth_year
  param :name_second_person, default: '', nils: true
  param :birth_year_second_person, default: nil, nils: true
  param :email
  param :city
  param :password
  param :password_confirmation
  param :pin
  param :pin_confirmation

  # add_error :kind, :blank, "nie może być puste" do
  #   params.kind.blank?
  # end

  [:kind, :name, :birth_year, :email, :city, :password, :password_confirmation, :pin, :pin_confirmation].each do |field|
    add_error field, :blank, "nie może być puste" do
      params.try(field).blank?
    end
  end

  # add_error :name_second_person, :blank, "nie może być puste" do
  #   params.name_second_person.blank? && params.kind.present? && !['man', 'woman'].include?(params.kind)
  # end

  # add_error :birth_year_second_person, :blank, "nie może być puste" do
  #   params.birth_year_second_person.blank? && params.kind.present? && !['man', 'woman'].include?(params.kind)
  # end

  add_error :password_confirmation, :same_as, "hasła nie są takie same" do
    params.password != params.password_confirmation
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
    CurrentUserStore.current_user_id! response.json['user']['id']
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