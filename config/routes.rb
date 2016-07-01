Rails.application.routes.draw do
  get 'changes/index'
  match "/changes", as: "changes", to: "changes#index", via: :get

  match "/plants/names/search/defaults/show_results_as", as: "plants_names_search_defaults_show_as", to: "plants/names/search/defaults/show_as#update", via: :post
  match "/plants/names/details", as: "plants_names_details", to: "plants/names/details#index", via: :get
  match "/plants/names/checklist", as: "plants_names_checklist", to: "plants/names/checklist#index", via: :get
  match "/plants/names/within/genus/search", as: "plants_names_within_genus_search", to: "plants/names/within/genus#search", via: :get
  match "/plants/names/within/genus", as: "plants_names_within_genus", to: "plants/names/within/genus#index", via: :get
  match "/plants/names/search/within/taxon/:id/at/rank/:rank", as: "plants_names_search_within_taxon_at_rank", to: "plants/names/search/within/taxon/at/rank#index", via: :get
  match "/plants/names/search/within/taxon/:id/summary", as: "plants_names_search_within_taxon_summary", to: "plants/names/search/within/taxon/summary#index", via: :get
  match "/plants/names/search/within/taxon/:id/all", as: "plants_names_search_within_taxon_all", to: "plants/names/search/within/taxon/all#index", via: :get

  match "/plants/names/search/within/taxon/selected_ranks/search", as: "plants_names_search_within_taxon_selected_ranks_search", to: "plants/names/search/within/taxon/selected_ranks/search#index", via: :get
  match "/plants/names/search/within/taxon/:id/selected_ranks", as: "plants_names_search_within_taxon_selected_ranks", to: "plants/names/search/within/taxon/selected_ranks#index", via: :get
  match "/plants/names/search/within/taxon/:id", as: "plants_names_search_within_taxon", to: "plants/names/search/within/taxon#index", via: :get
  match "/plants/names/within", as: "plants_names_within", to: "plants/names/within#index", via: :get
  match "/plants/names/advanced", as: "plants_names_advanced", to: "plants/names/advanced#index", via: :get
  match "/plants/names/search/search", as: "plants_names_search_search", to: "plants/names/search#search", via: :get
  match "/plants/names/search", as: "plants_names_search", to: "plants/names/search#index", via: :get
  match "/plants/name/:id", as: "plants_names_show", to: "plants/names#show", via: :get

  match "/plants/taxonomy/accepted/search/synonym", as: "plants_taxonomy_accepted_search_synonym", to: "plants/taxonomy/accepted/search/synonym#index", via: :get
  match "/plants/taxonomy/accepted/search/accepted", as: "plants_taxonomy_accepted_search_accepted", to: "plants/taxonomy/accepted/search/accepted#index", via: :get
  match "/plants/taxonomy/accepted/search/excluded", as: "plants_taxonomy_accepted_search_excluded", to: "plants/taxonomy/accepted/search/excluded#index", via: :get
  match "/plants/taxonomy/accepted/search/all", as: "plants_taxonomy_accepted_search_all", to: "plants/taxonomy/accepted/search/all#index", via: :get
  match "/plants/taxonomy/accepted/search/accepted-and-excluded", as: "plants_taxonomy_accepted_search_accepted_and_excluded", to: "plants/taxonomy/accepted/search/accepted_and_excluded#index", via: :get
  match "/plants/taxonomy/other", as: "plants_taxonomy_other", to: "plants/taxonomy/other#index", via: :get
  match "/plants/taxonomy/accepted/checklist", as: "plants_taxonomy_accepted_checklist", to: "plants/taxonomy/accepted/checklist#index", via: :get
  match "/plants/taxonomy/accepted/within", as: "plants_taxonomy_accepted_within", to: "plants/taxonomy/accepted/within#index", via: :get
  match "/plants/taxonomy/accepted/search", as: "plants_taxonomy_accepted_search", to: "plants/taxonomy/accepted/search#index", via: :get
  match "/plants/taxonomy/accepted/:id", as: "plants_taxonomy_accepted_show", to: "plants/taxonomy/accepted#show", via: :get
  match "/plants/taxonomy/accepted", as: "plants_taxonomy_accepted", to: "plants/taxonomy/accepted#index", via: :get
  match "/plants/taxonomy/other/:id/show", as: "plants_taxonomy_other_show", to: "plants/taxonomy/other#show", via: :get
  match "/plants/taxonomy/:id/show", as: "plants_taxonomy_show", to: "plants/taxonomy#show", via: :get
  match "/plants/taxonomy", as: "plants_taxonomy", to: "plants/taxonomy#index", via: :get
  match "/plants/names", as: "plants_names", to: "plants/names#index", via: :get
  match "/plants", as: "plants", to: "plants#index", via: :get
  match "/mosses", as: "mosses", to: "mosses#index", via: :get
  match "/fungi", as: "fungi", to: "fungi#index", via: :get
  match "/lichens", as: "lichens", to: "lichens#index", via: :get
  match "/algae", as: "algae", to: "algae#index", via: :get
  match "/fauna", as: "fauna", to: "fauna#index", via: :get
  match "/flora", as: "flora", to: "flora#index", via: :get

  match "/apni/about", as: "about_apni", to: "apni#about", via: :get
  match "/apni/index", as: "apni_index", to: "apni#index", via: :get
  match "/apni/search", as: "apni_search", to: "apni#search", via: :get
  match "/apni", as: "apni", to: "apni#index", via: :get

  get "apc/index"
  match "/apc", as: "apc", to: "apc#index", via: :get

  get "apni/search"

  get "search/index"

  get "search/apni"

  get "search/apc"

  post "editor" => "editor#toggle", as: :editor
  post "citations" => "citations#toggle", as: :citations
  post "always_details" => "always_details#toggle", as: :always_details
  get "config" => "config#index", as: :config

  # The priority is based upon order of creation:
  # first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  get "nsl", as: "explicit_nsl", to: "nsl#index", via: :get
  root "nsl#index", as: "nsl", via: :get

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
