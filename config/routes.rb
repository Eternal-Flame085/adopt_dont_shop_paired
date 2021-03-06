Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'shelters#shelters'

  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  post '/shelters', to: 'shelters#create'
  get 'shelters/:id', to: 'shelters#show'
  get 'shelters/:id/edit', to: 'shelters#edit'
  patch 'shelters/:id', to: 'shelters#update'
  delete 'shelters/:id', to: 'shelters#destroy'

  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  get '/shelters/:shelter_id/pets', to: 'shelters#pets_index'
  post '/shelters/:shelter_id/pets', to: 'pets#create'
  get '/shelters/:shelter_id/pets/new', to: 'pets#new'
  delete 'pets/:id', to: 'pets#destroy'

  get '/users/new', to: 'users#new'
  get '/users/:id', to: 'users#show'
  post '/users', to: 'users#create'

  get '/shelters/:shelter_id/new_review', to: 'reviews#new'
  post 'shelters/:shelter_id', to: 'reviews#create'
  get '/shelters/:shelter_id/:review_id/edit_review', to: 'reviews#edit'
  patch 'shelters/:shelter_id/:review_id', to: "reviews#update"
  delete '/shelters/:shelter_id/:review_id', to: 'reviews#delete'

  get '/applications/new', to: 'applications#new'
  post '/applications/create', to: 'applications#create'
  patch '/applications/:application_id', to: 'applications#edit'
  post '/applications/:application_id/add_pet', to: 'applications#add_pet'
  get '/applications/:application_id', to: 'applications#show'

  get '/admin/applications/:application_id', to: 'admin#show'
  patch '/admin/applications/:application_id/approve', to: 'admin#approve'
  patch '/admin/applications/:application_id/reject', to: 'admin#reject'

  get '/pets_applications/pets/:id', to: 'pets_applications#index'
end
