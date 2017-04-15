Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users

  resources :posts do
  	resources :comments
  	member do
  		get 'like'
    end
  end

  get 'profiles/show'
  get ':user_name', to: 'profiles#show', as: :profile
  get ':user_name/edit', to: 'profiles#edit', as: :edit_profile
  patch ':user_name/edit', to: 'profiles#update', as: :update_profile

  get 'hashtags/:hashtag', to: 'hashtags#show', as: :hashtag
  get 'hashtags', to: 'hashtags#index', as: :hashtags
end