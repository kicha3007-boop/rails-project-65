Rails.application.routes.draw do
  scope module: :web do
    root "bulletins#index"

    post "auth/:provider", to: "auth#request", as: :auth_request
    match "auth/:provider/callback", to: "auth#callback", as: :callback_auth, via: %i[get post]
    resource :session, only: :destroy

    resources :bulletins, only: %i[show new create edit update] do
      member do
        patch :to_moderate
        patch :archive
      end
    end

    resource :profile, only: :show

    namespace :admin do
      root "home#index"

      resources :bulletins, only: :index do
        member do
          patch :publish
          patch :reject
          patch :archive
        end
      end

      resources :categories, except: :show
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
