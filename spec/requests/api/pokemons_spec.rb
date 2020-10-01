# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pokemons API' do
  let_it_be(:pokemon) { create(:pokemon) }
  let(:attr) { %w[id name type_1 type_2 total hp attack defense sp_atk sp_def speed generation legendary] }
  let(:json) { JSON.parse(response.body) }

  describe 'GET /api/pokemons' do
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

  describe 'POST /api/pokemons' do
    context 'valid information' do
      let(:params) { { pokemon: attributes_for(:pokemon) } }

      it 'returns the new pokemon' do
        post api_pokemons_path(params)
        expect(json['name']).to eq(params[:pokemon][:name])
      end
    end

    context 'invalid information' do
      let(:params) { { pokemon: { name: '' } } }

      it 'returns validation errors' do
        post api_pokemons_path(params)
        expect(json['code']).to eq('422')
        expect(json['message']).to eq('Validation Failed')
        expect(json['errors']['name'][0]).to eq("can't be blank")
      end
    end
  end
end
