require 'rails_helper'

RSpec.describe 'Api::V1::People', type: :request do
  describe 'GET /api/v1/people' do
    context 'with searching and pagination' do
      let!(:people) { create_list(:person, 5) }
  
      before { get '/api/v1/people', params: { page: 1, size: 5 } }
  
      it 'returns a successful response' do
        expect(response).to have_http_status(:success)
      end
  
      it 'returns the correct number of people' do
        json_response = JSON.parse(response.body)
        expect(json_response['people'].size).to eq(5)
      end
  
      it 'returns the correct pagination information' do
        json_response = JSON.parse(response.body)
        expect(json_response['pagination']).to include(
          'current_page' => 1,
          'next_page' => nil,
          'prev_page' => nil,
          'total_pages' => 1,
          'total_count' => 5
        )
      end
  
      it 'returns the correct attributes for each person' do
        json_response = JSON.parse(response.body)
        json_response['people'].each do |person|
          expect(person).to include(
            'id',
            'first_name',
            'last_name',
            'species',
            'gender',
            'weapon',
            'vehicle',
            'locations',
            'affiliations'
          )
        end
      end
  
      context 'with search parameter' do
        let!(:matching_person) { create(:person, first_name: 'Chewbacca') }
        let!(:non_matching_person) { create(:person, first_name: 'Han') }
  
        before { get '/api/v1/people', params: { search: 'Chewbacca' } }
  
        it 'returns only the matching person' do
          json_response = JSON.parse(response.body)
          expect(json_response['people'].size).to eq(1)
          expect(json_response['people'].first['first_name']).to eq('Chewbacca')
        end
      end
    end

    context 'with sorting parameters' do
      let!(:person_a) { create(:person, first_name: 'Boba') }
      let!(:person_b) { create(:person, first_name: 'Ahsoka') }
  
      before { get '/api/v1/people', params: { sort_by: 'first_name', sort_order: 'asc' } }
  
      it 'returns people sorted by first name' do
        json_response = JSON.parse(response.body)
        expect(json_response['people'].map { |p| p['first_name'] }).to eq(['Ahsoka', 'Boba'])
      end
    end
  end
end