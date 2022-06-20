Rails.application.routes.draw do
  devise_for :users,
              controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }
  namespace :api do
    namespace :v1 do
      post "/users/playlist", to: "playlists#create"
      post "/users/playlist/song-lists", to: "playlists#add"
      delete "/users/playlist/song-lists", to: "playlists#destroy"

      resources :artists, only: %i[update]
      resources :groups do
        resource :playlist, only: %i[create add] do
          post "/song-lists", to: "playlists#add"
          delete "/song-lists", to: "playlists#destroy"
        end
      end

      # post "/users/playlist", to: "users#create_playlist"
      # post "/groups/:group_id/playlist", to: "groups#create_playlist"
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
