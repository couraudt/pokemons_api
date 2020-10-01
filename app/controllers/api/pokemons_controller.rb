# frozen_string_literal: true

module Api
  class PokemonsController < ApplicationController
    def index
      @pokemons = Pokemon.all
    end
  end
end
