Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      namespace :gym_memberships do
        resources :users, only: [:index]
      end

      resources :gym_search, only: [:index, :show]

      namespace :users do
        resources :find, only: [:index]
      end

      resources :users, only: [:show, :update, :create] do
        resources :gym_members, only: [:index], controller: 'users/gym_members'
        resources :events, only: [:index], controller: 'users/events'
        resources :friendships, only: [:index, :create, :destroy], controller: 'users/friendships'
        resources :gym_memberships, only: [:index, :create, :destroy], controller: 'users/gym_memberships' do
          resources :events, only: [:create, :destroy], controller: 'users/gym_memberships/events'
        end
      end
    end
  end
end
