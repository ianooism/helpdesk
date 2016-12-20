class Ticket < ApplicationRecord
  belongs_to :project
  belongs_to :author, class_name: "User"
end
