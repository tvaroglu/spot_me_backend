Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :users, only: [:show, :update, :create] do
        resources :events, only: [:index], controller: 'users/events'
        resources :friendships, only: [:index], controller: 'users/friendships'
        resources :gyms, only: [:index, :destroy], controller: 'users/gyms' do
          resources :events, only: [:create], controller: 'users/gyms/events'
          resources :gym_members, only: [:create], controller: 'users/gyms/gym_members'
        end
      end

      resources :gyms, only: [:show]
    end
  end
end
