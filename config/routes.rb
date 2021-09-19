Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :gym_search, only: [:index]
      delete 'users/:user_id/gyms/:gym_id', to: 'users/gyms/gym_members#destroy'
      resources :users, only: [:show, :update, :create] do
        resources :events, only: [:index], controller: 'users/events'
        resources :friendships, only: [:index, :destroy], controller: 'users/friendships'
        resources :gyms, only: [:index], controller: 'users/gyms' do
          resources :events, only: [:create], controller: 'users/gyms/events'
          resources :gym_members, only: [:create], controller: 'users/gyms/gym_members'
        end
      end

      resources :gyms, only: [:show]
    end
  end
end
