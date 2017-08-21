class ProcessLogout < Hyperloop::Operation

  step do
    HTTP.delete('/users/sign_out.json')
  end
  step do |response|
    puts 'POSZLO W OPERACJI'
    puts response.inspect
    CurrentUserStore.current_user_id! nil
    # CurrentUserStore.init_current_user
    {data: JSON.parse(response.body)}
  end
  # failed do |response|
  #   puts 'NIE POSZLO W OPERACJI'
  #   puts JSON.parse(response.body).inspect
  #   # {data: JSON.parse(response.body)}
  #   # Object.new({data: JSON.parse(response.body)})
  #   response
  # end
end