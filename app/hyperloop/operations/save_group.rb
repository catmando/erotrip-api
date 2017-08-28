class SaveGroup < Hyperloop::Operation
  param name: nil, nils: true
  param desc: nil, nils: true
  param kinds: [], nils: true
  param photo_uri: nil, nils: true

  [:name, :desc, :kinds].each do |field|
    add_error field, :blank, "nie może być puste" do
      params.try(field).blank? || params.try(field).empty?
    end
  end

  step do
    group = Group.new(name: params.name, desc: params.desc, kinds: params.kinds, photo_uri: params.photo_uri)
    puts "WILL SAVE GROUP #{group.inspect}"
    group.save.then
  end
  step do |response|
    puts response.inspect
    puts 'STEP2'
    unless response[:success]
      raise ArgumentError, response[:saved_models].first[3]
    end
    return Group.new(response[:saved_models].first[2])
  end
end