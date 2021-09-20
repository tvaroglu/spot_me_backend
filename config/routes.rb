Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :gym_search, only: [:index]
      resources :users, only: [:show, :update, :create] do
        resources :events, only: [:index], controller: 'users/events'
        resources :friendships, only: [:index, :create, :destroy], controller: 'users/friendships'
        resources :gym_memberships, only: [:index, :create, :destroy], controller: 'users/gym_memberships' do
          resources :events, only: [:create], controller: 'users/gym_memberships/events'
        end
      end

      resources :gyms, only: [:show]
    end
  end
end
