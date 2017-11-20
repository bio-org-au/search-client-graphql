# frozen_string_literal: true

# Rails plumbing.
Rails.application.routes.draw do
  match '/names/search', as: 'name_search', to: 'names#index', via: :get
  match '/name/:id', as: 'show_name', to: 'names#show', via: :get
  match '/names/:id', as: 'show_names', to: 'names#show', via: :get
  match '/search', as: 'search', to: 'names#index', via: :get
  match '/name/history/:id', as: 'name_history', to: 'names#history', via: :get
  match '/names/search/within/taxon/:id/summary',
        as: 'names_search_within_taxon_summary',
        to: 'names/search/within/taxon/summary#index',
        via: :get
  get '/index.*', to: 'names#index'
  match '/names/advanced', as: 'names_advanced_search',
                           to: 'advanced_names#index', via: :get
  match '/taxonomy/search', as: 'taxonomy_search',
                            to: 'taxonomy#index', via: :get
  root to: 'names#index'
  get '*path' => 'names#index'
end
