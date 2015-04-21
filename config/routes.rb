Rails.application.routes.draw do
  resources :emergencies, only: [:index, :show, :create, :update, :destroy], defaults: { format: 'json' }, param: :code
  resources :responders, only: [:index, :show, :create, :update, :destroy], defaults: { format: 'json' }, param: :name

  match '*path', to: 'application#not_found', via: :all
end
