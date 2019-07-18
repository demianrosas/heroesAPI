Rails.application.routes.draw do
  resources :heroes do
    resources :missions
  end
end
