class ProcessLogin < Hyperloop::Operation
  param :email, type: String
  param :password, type: String

  add_error :email, :blank, "nie może być puste" do
    params.email.blank?
  end

  add_error :password, :blank, "nie może być puste" do
    params.password.blank?
  end

  # add_error :email, :invalid, "niepoprawny format" do
  #   r = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  #   (r =~ params.email).blank?
  # end

  step do
    HTTP.post('/users/sign_in.json', payload: { user: { email: params.email, password: params.password } } )
  end
  step do |response|
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