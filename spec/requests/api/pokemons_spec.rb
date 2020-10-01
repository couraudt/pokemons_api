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
    context 'valid pokemon id' do
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

    context 'invalid pokemon id' do
      it 'returns 404 message' do
        get api_pokemon_path(1337)
        expect(json['code']).to eq('404')
        expect(json['message']).to eq('Not found')
      end
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

  describe 'PUT /api/pokemons/:id' do
    context 'valid information' do
      let(:params) { { id: pokemon.id, pokemon: { name: 'Picka v2' } } }

      it 'returns the new pokemon' do
        put api_pokemon_path(params)
        expect(json['name']).to eq(params[:pokemon][:name])
      end
    end

    context 'invalid information' do
      let(:params) { { id: pokemon.id, pokemon: { name: '' } } }

      it 'returns validation errors' do
        put api_pokemon_path(params)
        expect(json['code']).to eq('422')
        expect(json['message']).to eq('Validation Failed')
        expect(json['errors']['name'][0]).to eq("can't be blank")
      end
    end

    context 'invalid pokemon id' do
      let(:params) { { id: 1337, pokemon: { name: 'Picka v2' } } }

      it 'returns 404 message' do
        put api_pokemon_path(params)
        expect(json['code']).to eq('404')
        expect(json['message']).to eq('Not found')
      end
    end
  end

  describe 'DELETE /api/pokemons/:id' do
    context 'valid pokemon id' do
      it 'returns no json' do
        delete api_pokemon_path(id: pokemon.id)
        expect(response.body).to eq('')
      end
    end

    context 'invalid pokemon id' do
      it 'returns 404 message' do
        delete api_pokemon_path(id: 1337)
        expect(json['code']).to eq('404')
        expect(json['message']).to eq('Not found')
      end
    end
  end
end
