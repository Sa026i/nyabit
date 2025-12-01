Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  root "tops#top"
  get "home/top"

  resources :users, only: %i[show edit update]
  resources :habits, only: %i[index new create edit update destroy] do
    resources :habit_logs, only: :create
  end

  resources :calendars, only: :index

  get "up" => "rails/health#show", as: :rails_health_check #ヘルスチェック

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # カスタムエラーページ用のルート
  get '/404', to: 'errors#not_found', as: :not_found
  get '/500', to: 'errors#internal_server_error', as: :internal_server_error

  # すべての未知のルートを404エラーページへリダイレクト
  match '*path', to: 'errors#not_found', via: :all

  # Defines the root path route ("/")
  # root "posts#index"
end
