Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  root 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'
  devise_for :users
  resources :users, only: [:show,:index,:edit,:update] do
    # collection do
    #   get 'search'
    # end
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member 
    get :followers, on: :member
  end
  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end  
  
  get 'search' => 'searches#search'
  
end