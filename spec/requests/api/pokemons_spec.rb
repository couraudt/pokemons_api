# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pokemons API' do
  let_it_be(:pokemon) { create(:pokemon) }
  let(:attr) { %w[id name type_1 type_2 total hp attack defense sp_atk sp_def speed generation legendary] }

  describe 'GET /api/pokemons' do
    let(:json) { JSON.parse(response.body) }

    before { get api_pokemons_path }

    it 'returns json array of pokemons' do
      expect(json.count).to eq(1)
    end

    it 'has the required attributes with value' do
      attr.each do |attribute|
        expect(json[0][attribute]).to eq(pokemon[attribute])
      end
    end

    it 'has the required number of attributes' do
      expect(json[0].count).to eq(attr.count)
    end
  end

  describe 'GET /api/pokemons/:id' do
    let(:json) { JSON.parse(response.body) }

    before { get api_pokemon_path(pokemon) }

    it 'has the required attributes with value' do
      attr.each do |attribute|
        expect(json[attribute]).to eq(pokemon[attribute])
      end
    end

    it 'has the required number of attributes' do
      expect(json.count).to eq(attr.count)
    end
  end
end
