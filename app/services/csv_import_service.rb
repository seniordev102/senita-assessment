require 'csv'

class CsvImportService
  def initialize(file)
    @file = file
  end

  def call
    CSV.foreach(@file.path, headers: true, col_sep: ",") do |row|
      next if row['Affiliations'].nil?

      person = Person.find_or_initialize_by(first_name: format_name(row['Name'].split.first))
      person.assign_attributes(
        last_name: row['Name'].split[1..]&.join(" "),
        species: row['Species'],
        gender: row['Gender'].downcase == 'm' ? 'Male' : row['Gender'].downcase == 'f' ? 'Female' : row['Gender'],
        weapon: row['Weapon'],
        vehicle: row['Vehicle']
      )
      person.save!

      row['Location'].split(', ').each do |loc|
        location = Location.find_or_create_by(name: format_name(loc))
        person.locations << location unless person.locations.include?(location)
      end

      row['Affiliations'].split(', ').each do |aff|
        affiliation = Affiliation.find_or_create_by(name: format_name(aff))
        person.affiliations << affiliation unless person.affiliations.include?(affiliation)
      end
    end
  end

  private

  def format_name(name)
    name.split.map(&:capitalize).join(" ")
  end
end
