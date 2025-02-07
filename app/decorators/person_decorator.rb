# app/decorators/person_decorator.rb

class PersonDecorator
  def initialize(person)
    @person = person
  end

  def as_json(*)
    {
      id: @person.id,
      first_name: @person.first_name,
      last_name: @person.last_name,
      species: @person.species,
      gender: @person.gender,
      weapon: @person.weapon,
      vehicle: @person.vehicle,
      locations: locations,
      affiliations: affiliations
    }
  end

  private

  def locations
    @person.locations.map { |location| { id: location.id, name: location.name } }
  end

  def affiliations
    @person.affiliations.map { |affiliation| { id: affiliation.id, name: affiliation.name } }
  end
end