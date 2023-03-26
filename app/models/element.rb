class Element < ApplicationRecord
  belongs_to :group
  validates_presence_of :name
  validates_presence_of :atomic_number
  validates_presence_of :atomic_mass
  validates_presence_of :symbol
  validates_presence_of :description
end
