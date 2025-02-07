import { Person, Location, Affiliation } from '../types';

export const parseFetchPeopleApiResponse = (response: any): { people: Person[], pagination: any } => {
  const people = response.people.map((item: any) => {
    return {
      id: item.id,
      first_name: item.first_name,
      last_name: item.last_name,
      species: item.species,
      gender: item.gender,
      weapon: item.weapon,
      vehicle: item.vehicle,
      locations: item.locations.map((loc: any) => ({
        id: loc.id,
        name: loc.name
      })),
      affiliations: item.affiliations.map((aff: any) => ({
        id: aff.id,
        name: aff.name
      })),
    };
  });

  return people
};