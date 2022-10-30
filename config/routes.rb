Rails.application.routes.draw do

  get 'posts/haha'

  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :posts
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"


  authenticate :user, lambda { |u| u.admin? } do
    begin
      mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
    rescue
      redirect_to new_user_session_path
    end
  end

  root 'posts#index'

  resources :comments, only: [:create, :destroy]

  resources :posts do
    member do
      put "like", to:    "posts#upvote"
      put "dislike", to: "posts#downvote"
    end
  end

  

end
