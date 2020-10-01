# frozen_string_literal: true

module Api
  class PokemonsController < ApplicationController
    before_action :find_pokemon, only: [:show]

    def index
      @pokemons = Pokemon.all
    end

    def show; end

    private

    def find_pokemon
      @pokemon = Pokemon.where(id: params[:id]).first
      head :not_found unless @pokemon
    end
  end
end
