# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::PokemonsController do
  let_it_be(:pokemon) { create(:pokemon) }

  describe 'GET #index' do
    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_successful
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #show' do
    context 'valid pokemon id' do
      it 'responds successfully with an HTTP 200 status code' do
        get :show, params: { id: pokemon.id }
        expect(response).to be_successful
        expect(response.status).to eq(200)
      end
    end

    context 'invalid pokemon id' do
      it 'responds with an HTTP 404 status code' do
        get :show, params: { id: 1337 }
        expect(response.status).to eq(404)
      end
    end
  end
end
