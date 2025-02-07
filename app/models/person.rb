class Person < ApplicationRecord
  has_many :person_locations
  has_many :locations, through: :person_locations

  has_many :person_affiliations
  has_many :affiliations, through: :person_affiliations

  validates :first_name, :species, :gender, presence: true

  scope :search, ->(term) {
    where("lower(first_name) LIKE :search OR lower(last_name) LIKE :search", search: "%#{term.downcase}%")
  }

  scope :sorted, ->(sort_column, sort_order) {
    order("#{sort_column} #{sort_order}")
  }
end
