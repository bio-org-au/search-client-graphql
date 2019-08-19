# frozen_string_literal: true

# Rails plumbing.
Rails.application.routes.draw do
  get 'publications/suggestions'

  match '/hello', as: 'hello_page', to: 'hello#index', via: :get
  match '/filtered/search', as: 'filtered_search', to: 'filtered_search#index', via: :get
  match '/names/search', as: 'name_search', to: 'names#index', via: :get
  match '/name/check', as: 'name_check', to: 'name_check#index', via: :get
  match '/name/check/search', as: 'name_check_search',
                            to: 'name_check#index', via: :get
  match '/name/:id', as: 'show_name', to: 'names#show', via: :get
  match '/search', as: 'search', to: 'names#index', via: :get
  match '/name/history/:id', as: 'name_history', to: 'names#history', via: :get
  match '/names/search/within/taxon/:id/summary',
        as: 'names_search_within_taxon_summary',
        to: 'names/search/within/taxon/summary#index',
        via: :get
  get '/index.*', to: 'names#index'
  match '/names/advanced', as: 'names_advanced_search',
                           to: 'advanced_names#index', via: :get
  match '/names/:id', as: 'show_names', to: 'names#show', via: :get
  match '/taxonomy/search', as: 'taxonomy_search',
                            to: 'taxonomy#index', via: :get
  match '/publications/suggestions/:search_term', as: 'publication_suggestions', to: 'publications#suggestions', via: :get
  get '/settings', as: 'settings', to: 'settings#index'
  get '/settings/index', as: 'settings_index', to: 'settings#index'


  # Editor Links Section
  # Allow from browser, so 'get', for bookmarking.
  match '/I-am-an-editor', as: 'I_am_an_editor', to: 'preferences#editor_switch', via: [:get], defaults: { switch: 'editor', value: 'on' }
  match '/i-am-an-editor', as: 'i_am_an_editor', to: 'preferences#editor_switch', via: [:get], defaults: { switch: 'editor', value: 'on' }
  # Use as hidden link, needs to be a post to avoid apparent auto getting.
  match '/i-am-an-editor-post', as: 'i_am_an_editor_post', to: 'preferences#editor_switch', via: [:post], defaults: { switch: 'editor', value: 'on' }
  # Use "post" and indicate this is a post for consistency.
  match '/i-am-not-an-editor-post', as: 'i_am_not_an_editor_post', to: 'preferences#editor_switch', via: [:post], defaults: { switch: 'editor', value: 'off' }
  # 
  post '/background', to: 'settings#background'

  root to: 'names#index'
  get '*path' => 'names#index'
end
