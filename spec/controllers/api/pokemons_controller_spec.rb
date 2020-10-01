# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::PokemonsController do
  describe 'GET #index' do
    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.status).to eq(200)
    end
  end
end
