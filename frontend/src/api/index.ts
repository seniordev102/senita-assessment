// src/api.ts

import axios from 'axios';
import { Person } from '../types';

const API_BASE_URL = process.env.REACT_APP_API_URL;

export const fetchPeople = async (params: {
  page: number;
  size: number;
  search: string;
  sort_by: string;
  sort_order: string;
}): Promise<{ people: Person[]; pagination: any }> => {
  const response = await axios.get(`${API_BASE_URL}/people`, { params });
  return response.data;
};