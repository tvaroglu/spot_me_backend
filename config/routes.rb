Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :gym_search, only: [:index, :show]
      namespace :users do
        resources :find, only: [:index]
      end

      resources :users, only: [:show, :update, :create] do
        # TODO: explore adding user information into events index via serializer
        resources :events, only: [:index], controller: 'users/events'
        # TODO: need an endpoint of user's friends at the gym and user's at the gym (for gym show page, if member)
        resources :friendships, only: [:index, :create, :destroy], controller: 'users/friendships'
        resources :gym_memberships, only: [:index, :create, :destroy], controller: 'users/gym_memberships' do
          resources :events, only: [:create, :destroy], controller: 'users/gym_memberships/events'
        end
      end

    end
  end
end
