# frozen_string_literal: true

Rails.application.routes.draw do
  match '/names/search',
        as: 'name_search',
        to: 'name#index',
        via: :get
  match '/name/:id',
        as: 'name_show',
        to: 'name#show',
        via: :get
  match '/search',
        as: 'search',
        to: 'name#index',
        via: :get
  match '/name/history/:id',
        as: 'name_history',
        to: 'names#history',
        via: :get
  match '/names/search/within/taxon/:id/summary',
        as: 'names_search_within_taxon_summary',
        to: 'names/search/within/taxon/summary#index',
        via: :get
  get '/index.*',
      to: 'name#index'
  match '/names/advanced',
        as: 'names_advanced_search',
        to: 'advanced_name#index',
        via: :get
  match '/taxonomy/search',
        as: 'taxonomy_search',
        to: 'taxonomy#index',
        via: :get
  root to: 'name#index'
  get '*path' => 'name#index'
end
