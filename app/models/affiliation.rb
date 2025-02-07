class Affiliation < ApplicationRecord
  has_many :person_affiliations
  has_many :people, through: :person_affiliations

  validates :name, presence: true, uniqueness: true
end
