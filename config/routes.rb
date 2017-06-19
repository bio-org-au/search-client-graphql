# frozen_string_literal: true
Rails.application.routes.draw do
  get "changes/index"
  match "/changes", as: "changes", to: "changes#index", via: :get

  match "/names/search/defaults/show_results_as",
        as: "names_search_defaults_show_as",
        to: "names/search/defaults/show_as#update", via: :post
  match "/names/details",
        as: "names_details",
        to: "names/details#index",
        via: :get
  match "/names/checklist",
        as: "names_checklist",
        to: "names/checklist#index",
        via: :get
  match "/names/within/genus/search",
        as: "names_within_genus_search",
        to: "names/within/genus#search",
        via: :get
  match "/names/within/genus",
        as: "names_within_genus",
        to: "names/within/genus#index",
        via: :get
  match "/names/search/within/taxon/:id/at/rank/:rank",
        as: "names_search_within_taxon_at_rank",
        to: "names/search/within/taxon/at/rank#index",
        via: :get
  match "/names/search/within/taxon/:id/summary",
        as: "names_search_within_taxon_summary",
        to: "names/search/within/taxon/summary#index",
        via: :get
  match "/names/search/within/taxon/:id/all",
        as: "names_search_within_taxon_all",
        to: "names/search/within/taxon/all#index",
        via: :get

  match "/names/search/within/taxon/selected_ranks/search",
        as: "names_search_within_taxon_selected_ranks_search",
        to: "names/search/within/taxon/selected_ranks/search#index",
        via: :get
  match "/names/search/within/taxon/:id/selected_ranks",
        as: "names_search_within_taxon_selected_ranks",
        to: "names/search/within/taxon/selected_ranks#index",
        via: :get
  match "/names/within",
        as: "names_within",
        to: "names/within#index",
        via: :get
  match "/names/search",
        as: "names_search",
        to: "names/search#index",
        via: :get
  match "/name/:id",
        as: "names_show",
        to: "names#show",
        via: :get
  match "/name/raw/:id",
        as: "names_raw",
        to: "names#raw",
        via: :get

  match "/taxonomy/accepted/search/synonym",
        as: "taxonomy_accepted_search_synonym",
        to: "taxonomy/accepted/search/synonym#index",
        via: :get
  match "/taxonomy/accepted/search/accepted",
        as: "taxonomy_accepted_search_accepted",
        to: "taxonomy/accepted/search/accepted#index",
        via: :get
  match "/taxonomy/accepted/search/excluded",
        as: "taxonomy_accepted_search_excluded",
        to: "taxonomy/accepted/search/excluded#index",
        via: :get
  match "/taxonomy/accepted/search/all",
        as: "taxonomy_accepted_search_all",
        to: "taxonomy/accepted/search/all#index",
        via: :get
  match "/taxonomy/accepted/search/accepted-and-excluded",
        as: "taxonomy_accepted_search_accepted_and_excluded",
        to: "taxonomy/accepted/search/accepted_and_excluded#index",
        via: :get
  match "/taxonomy/other",
        as: "taxonomy_other",
        to: "taxonomy/other#index",
        via: :get
  match "/taxonomy/accepted/checklist",
        as: "taxonomy_accepted_checklist",
        to: "taxonomy/accepted/checklist#index",
        via: :get
  match "/taxonomy/accepted/within",
        as: "taxonomy_accepted_within",
        to: "taxonomy/accepted/within#index",
        via: :get
  match "/taxonomy/accepted/search",
        as: "taxonomy_accepted_search",
        to: "taxonomy/accepted/search#index",
        via: :get
  match "/taxonomy/accepted/:id",
        as: "taxonomy_accepted_show",
        to: "taxonomy/accepted#show",
        via: :get
  match "/taxonomy/accepted",
        as: "taxonomy_accepted",
        to: "taxonomy/accepted#index",
        via: :get
  match "/taxonomy/other/:id/show",
        as: "taxonomy_other_show",
        to: "taxonomy/other#show",
        via: :get
  match "/taxonomy/:id/show",
        as: "taxonomy_show",
        to: "taxonomy#show",
        via: :get
  match "/taxonomy",
        as: "taxonomy",
        to: "taxonomy#index",
        via: :get

  post "editor" => "editor#toggle", as: :editor
  post "citations" => "citations#toggle", as: :citations


  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  namespace :taxonomy do
    post "show_hide_taxonomy_details" => "details#show_hide", as: :details_show_hide
    post "include_exclude_taxonomy_details" => "details#include_exclude", as: :details_include_exclude
    get  "load_details" => "details#load", as: :details_load
  end
   
  post "always_details" => "always_details#toggle", as: :always_details
  get "config" => "config#index", as: :config
  match "/names/search/about",
        as: "name_search_about",
        to: "names/search/about#index",
        via: :get
  match "/taxonomy/accepted/search/about",
        as: "taxonomy_accepted_search_about",
        to: "taxonomy/accepted/search/about#index",
        via: :get
  match "/toggle-wildcard",
        as: "toggle_wildcard",
        to: "toggle_wildcard#update",
        via: [:post, :get]

  match "/image-cache/update",
        as: "update_image_cache",
        to: "image_cache#update",
        via: [:post]

  # The priority is based upon order of creation:
  # first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # get "nsl", as: "explicit_nsl", to: "nsl#index", via: :get  # delete
  root "home#index", as: "root", via: :get
  match "/*random", to: "home#index", via: [:get, :post, :delete, :patch]

  # Example of regular route:
  #   get "products/:id" => "catalog#view"

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get "products/:id/purchase" => "catalog#purchase", as: :purchase

  # Example resource route
  # (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get "short"
  #       post "toggle"
  #     end
  #
  #     collection do
  #       get "sold"
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get "recent", on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post "toggle"
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
