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
    it 'responds successfully with an HTTP 200 status code' do
      get :show, params: { id: pokemon.id }
      expect(response).to be_successful
      expect(response.status).to eq(200)
    end
  end

  describe 'POST #create' do
    context 'valid information' do
      let(:params) { { pokemon: attributes_for(:pokemon) } }

      it 'responds successfully with an HTTP 200 status code' do
        post :create, params: params
        expect(response).to be_successful
        expect(response.status).to eq(200)
      end

      it 'create a pokemon in db' do
        expect { post :create, params: params }.to change { Pokemon.count }.by(1)
      end
    end

    context 'invalid information' do
      let(:params) { { pokemon: { name: '' } } }

      it 'responds with an HTTP 422 status code' do
        post :create, params: params
        expect(response.status).to eq(422)
      end

      it 'do not create a pokemon in db' do
        expect { post :create, params: params }.to change { Pokemon.count }.by(0)
      end
    end
  end

  describe 'PUT #update' do
    context 'valid information' do
      let(:params) { { id: pokemon.id, pokemon: { name: 'Picka v2' } } }

      it 'responds successfully with an HTTP 200 status code' do
        put :update, params: params
        expect(response).to be_successful
        expect(response.status).to eq(200)
      end

      it 'do not create a pokemon in db' do
        expect { put :update, params: params }.to change { Pokemon.count }.by(0)
      end
    end

    context 'invalid information' do
      let(:params) { { id: pokemon.id, pokemon: { name: '' } } }

      it 'responds with an HTTP 422 status code' do
        put :update, params: params
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'valid information' do
      it 'responds successfully with an HTTP 200 status code' do
        delete :destroy, params: { id: pokemon.id }
        expect(response).to be_successful
        expect(response.status).to eq(200)
      end

      it 'delete the pokemon in db' do
        expect { delete :destroy, params: { id: pokemon.id } }.to change { Pokemon.count }.by(-1)
      end
    end
  end
end
