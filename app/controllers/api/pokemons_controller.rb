# frozen_string_literal: true

module Api
  class PokemonsController < BaseController
    before_action :find_pokemon, only: %i[show update destroy]

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

    def destroy
      @pokemon.destroy
      head :ok
    end

    private

    def find_pokemon
      @pokemon = Pokemon.find(params[:id])
    end

    def pokemon_params
      params.require(:pokemon).permit(%i[name type_1 type_2 total hp attack defense sp_atk sp_def speed generation legendary])
    end
  end
end
