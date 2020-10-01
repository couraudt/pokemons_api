# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    resources :pokemons
    match '*path', to: 'pokemons#catch_404', via: :all
  end
end
