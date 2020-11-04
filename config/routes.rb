Rails.application.routes.draw do
  resources :copy, only: [:show, :index], constraints: { id: /[0-z\.]+/ } do
    collection do
      get :refresh
      get :copies
    end
  end
end
