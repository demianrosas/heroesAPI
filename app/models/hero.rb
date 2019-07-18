class Hero < ApplicationRecord
  has_many :missions, dependent: :destroy

  # validations
  validates_presence_of :name, :superpower, :company, :alignment
end
