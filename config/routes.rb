Rails.application.routes.draw do
  
  devise_for :users

  #api
  namespace :api do
    #namespace :v1 do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :users, only: [:index, :create, :show, :update, :destroy]
      resources :entries, only: [:index, :create, :show, :update, :destroy] do
        member do
          put 'upvote'
          put 'downvote'
        end
      end
    end
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  #resources :entries, only: [:show, :index]
  # resources :entries do
  #   member do
  #     put "upvote", to: "entries#upvote"
  #     put "downvote", to: "entries#downvote"
  #   end
  # end

  #resources :entries, only: [:show, :index, :new] do
  resources :entries do
    member do
      put 'upvote'
      put 'downvote'
    end
  end

  resources :quotes, except: [:edit, :update]
  resources :pictures, except: [:edit, :update]

  resources :links do
    member do
      put "upvote", to: "links#upvote"
      put "downvote", to: "links#downvote"
    end
  end

  resources :comments do
    member do
      put "upvote", to: "comments#upvote"
      put "downvote", to: "comments#downvote"
    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  #get 'profile/:id' => 'users#show'
  #get 'profile/:id/setting' => 'users#edit'
  #match 'profile/:id/setting' => 'users#update', via: [:put, :patch]

  get 'users/:id' => 'users#show', as: :user_profile
  get 'users/:id/edit' => 'users#edit', as: :edit_user_profile
  match 'users/:id/edit' => 'users#update', via: [:put, :patch], as: :user

  root 'entries#index'



  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
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
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
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
