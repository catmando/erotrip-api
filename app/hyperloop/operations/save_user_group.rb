class SaveUserGroup < Hyperloop::Operation
  param user_id: nil, nils: true
  param group_id: nil, nils: true
  param public: nil, nils: true

  [:user_id, :group_id].each do |field|
    add_error field, :blank, "nie może być puste" do
      params.try(field).blank?
    end
  end

  add_error :public, :blank, "musisz wybrać" do
    params.try(:public).nil?
  end

  step do
    user_group = UserGroup.new(user_id: params.user_id, group_id: params.group_id, public: params.public)
    user_group.save.then
  end
  step do |response|
    unless response[:success]
      raise ArgumentError, response[:saved_models].first[3]
    end
    return Group.new(response[:saved_models].first[2])
  end
end