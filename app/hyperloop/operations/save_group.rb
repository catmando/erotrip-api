class SaveGroup < Hyperloop::Operation
  param name: nil, nils: true
  param desc: nil, nils: true
  param kinds: [], nils: true

  [:name, :desc, :kinds].each do |field|
    add_error field, :blank, "nie może być puste" do
      params.try(field).blank? || params.try(field).empty?
    end
  end

  step do
    group = Group.new(name: params.name, desc: params.desc, kinds: params.kinds)
    puts "WILL SAVE GROUP #{group.inspect}"
    group.save
  end
end