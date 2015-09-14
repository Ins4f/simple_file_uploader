Rails.application.routes.draw do
  resources :users, only: [:show, :create, :destroy, :update, :index], defaults: { format: :json } do
    member do
      get :field_naming
      get :sign_request
      post :complete_upload
      delete :delete_upload
    end
  end
end