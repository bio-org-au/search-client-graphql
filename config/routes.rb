# frozen_string_literal: true

Rails.application.routes.draw do
  match '/names/search',
        as: 'names_search',
        to: 'search#index',
        via: :get
  match '/search',
        as: 'search',
        to: 'search#index',
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
      to: 'search#index'
  match '/names/advanced',
        as: 'names_advanced_search',
        to: 'advanced_search#index',
        via: :get
  root to: 'search#index'
  get '*path' => 'search#index'
end

