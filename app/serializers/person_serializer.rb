class PersonSerializer
  include JSONAPI::Serializer

  attributes :id, :first_name, :last_name, :species, :gender, :weapon, :vehicle

  attribute :locations do |person|
    person.locations.map { |location| { id: location.id, name: location.name } }
  end

  attribute :affiliations do |person|
    person.affiliations.map { |affiliation| { id: affiliation.id, name: affiliation.name } }
  end
end