class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  belongs_to :created_by, class_name: "User", optional: true
  belongs_to :updated_by, class_name: "User", optional: true
end
