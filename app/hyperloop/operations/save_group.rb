class SaveGroup < Hyperloop::Operation
  param name: nil, nils: true
  param desc: nil, nils: true
  param kinds: [], nils: true
  param photo_uri: nil, nils: true

  [:name, :desc, :kinds, :photo_uri].each do |field|
    add_error field, :blank, "nie może być puste" do
      params.try(field).blank? || params.try(field).empty?
    end
  end

  step do
    group = Group.new(name: params.name, desc: params.desc, kinds: params.kinds, photo_uri: params.photo_uri)
    puts "WILL SAVE GROUP #{group.inspect}"
    {status: group.save, group: group}
  end
  step do |response|
    unless response[:status]
      raise ArgumentError, response[:user].errors.messages.to_json
    end
  end
end