# spec/factories/people.rb

FactoryBot.define do
  factory :person do
    first_name { "John" }
    last_name { "Doe" }
    species { "Human" }
    gender { "Male" }
    weapon { "None" }
    vehicle { "None" }

    # If you want to set up associations, you can do so here
    # after(:create) do |person|
    #   create_list(:location, 2, person: person) # Example for locations
    #   create_list(:affiliation, 1, person: person) # Example for affiliations
    # end
  end
end