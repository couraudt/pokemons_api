# frozen_string_literal: true

module Api
  class PokemonsController < ApplicationController
    before_action :find_pokemon, only: %i[show update]

    def index
      @pokemons = Pokemon.all
    end

    def show; end

    def create
      @pokemon = Pokemon.new(pokemon_params)
      if @pokemon.save
        render :show
      else
        render_errors(@pokemon.errors)
      end
    end

    def update
      if @pokemon.update(pokemon_params)
        render :show
      else
        render_errors(@pokemon.errors)
      end
    end

    private

    def find_pokemon
      @pokemon = Pokemon.where(id: params[:id]).first
      head :not_found unless @pokemon
    end

    def pokemon_params
      params.require(:pokemon).permit(%i[name type_1 type_2 total hp attack defense sp_atk sp_def speed generation legendary])
    end

    def render_errors(errors)
      render json: { code: '422', message: 'Validation Failed', errors: errors.messages }, status: :unprocessable_entity
    end
  end
end
