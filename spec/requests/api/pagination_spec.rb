# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pagination for pokemons API' do
  let_it_be(:pokemons) { create_list(:pokemon, Api::BaseController.results_per_page + 1) }
  let(:json) { JSON.parse(response.body) }

  context 'on first page' do
    before { get api_pokemons_path(page: 1) }

    it 'returns pagination header' do
      expect(response.headers['Total']).to eq((Api::BaseController.results_per_page + 1).to_s)
      expect(response.headers['Per-Page']).to eq(Api::BaseController.results_per_page.to_s)
      expect(response.headers['Link'].split(', ')).to include("<#{api_pokemons_url}?page=2>; rel=\"last\"")
      expect(response.headers['Link'].split(', ')).to include("<#{api_pokemons_url}?page=2>; rel=\"next\"")
    end

    it 'returns related objects' do
      expect(json.count).to eq(Api::BaseController.results_per_page)
    end
  end

  context 'on last page' do
    before { get api_pokemons_path(page: 2) }

    it 'returns pagination header' do
      expect(response.headers['Total']).to eq((Api::BaseController.results_per_page + 1).to_s)
      expect(response.headers['Per-Page']).to eq(Api::BaseController.results_per_page.to_s)
      expect(response.headers['Link'].split(', ')).to include("<#{api_pokemons_url}?page=1>; rel=\"first\"")
      expect(response.headers['Link'].split(', ')).to include("<#{api_pokemons_url}?page=1>; rel=\"prev\"")
    end

    it 'returns related object' do
      expect(json.count).to eq(1)
    end
  end

  context 'on non existent page' do
    before { get api_pokemons_path(page: 1337) }

    it 'returns pagination header on non existent page' do
      expect(response.headers['Total']).to eq((Api::BaseController.results_per_page + 1).to_s)
      expect(response.headers['Per-Page']).to eq(Api::BaseController.results_per_page.to_s)
      expect(response.headers['Link'].split(', ')).to include("<#{api_pokemons_url}?page=1>; rel=\"first\"")
      expect(response.headers['Link'].split(', ')).to include("<#{api_pokemons_url}?page=1336>; rel=\"prev\"")
    end

    it 'returns empty array on non existent page' do
      expect(json.count).to eq(0)
    end
  end
end
