# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Base Controller API' do
  let(:json) { JSON.parse(response.body) }

  it 'have no cookie header' do
    get api_pokemons_path
    expect(response.headers.key?('Set-Cookie')).to be_falsey
  end

  context 'with invalid route' do
    it 'returns 404 not found' do
      get '/api/do/not/exists'
      expect(json['code']).to eq('404')
      expect(json['message']).to eq('Not found')
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'with invalid id' do
    it 'returns 404 not found' do
      get api_pokemon_path(1337)
      expect(json['code']).to eq('404')
      expect(json['message']).to eq('Not found')
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'with missing parameters' do
    it 'returns 422 unprocessable entity' do
      post api_pokemons_path
      expect(json['code']).to eq('422')
      expect(json['message']).to eq('Parameters are missing')
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'with internal error' do
    it 'returns 500 internal error' do
      # See ApplicationController#rescue_from(StandardError)
      ENV['CATCH_EXCEPTION_DURING_TEST'] = '1'
      allow_any_instance_of(Api::PokemonsController).to receive(:index).and_raise(StandardError.new('error'))
      get api_pokemons_path
      expect(json['code']).to eq('500')
      expect(json['message']).to eq('Internal Server Error')
      expect(response).to have_http_status(:internal_server_error)
      ENV.delete('CATCH_EXCEPTION_DURING_TEST')
    end
  end
end
