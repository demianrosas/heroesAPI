class Mission < ApplicationRecord
  belongs_to :hero

  # validation
  validates_presence_of :description, :place, :date, :status
end
