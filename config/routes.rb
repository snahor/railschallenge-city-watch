Rails.application.routes.draw do
  resources :emergencies, only: [:index, :show, :create, :update, :destroy], defaults: { format: 'json' }

  match '*path', to: 'application#not_found', via: :all
end
