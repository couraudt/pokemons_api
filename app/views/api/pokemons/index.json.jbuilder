# frozen_string_literal: true

json.array! @pokemons, partial: 'api/pokemons/pokemon', as: :pokemon, cached: true
