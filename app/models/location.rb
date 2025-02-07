class Location < ApplicationRecord
  has_many :person_locations
  has_many :people, through: :person_locations

  validates :name, presence: true, uniqueness: true
end
