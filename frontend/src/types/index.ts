export interface Location {
  id: string;
  name: string;
}

export interface Affiliation {
  id: string;
  name: string;
}

export interface Person {
  id: string;
  first_name: string;
  last_name: string;
  species: string;
  gender: string;
  weapon?: string;
  vehicle?: string;
  locations: Location[];
  affiliations: Affiliation[];
}

export interface Pagination {
  current_page: number;
  next_page: number | null;
  prev_page: number | null;
  total_count: number;
  total_pages: number;
}