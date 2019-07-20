Rails.application.routes.draw do
  devise_for :users
  root 'home#top'
  get "home/about"=>"home#about"

  resources :books, only: [:index,:show,:create,:edit,:update,:destroy] do
    resources :book_comments, only: [:create,:destroy]
    resource :book_favorites, only: [:show,:create,:destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create,:destroy]
    get "/relationships/following"=>"relationships#following_index"
    get "/relationships/follower"=>"relationships#follower_index"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
