Rails.application.routes.draw do
  get 'main/index'

  get 'main/cert_verification'

  get 'main/sign_document'

  post 'main/document_signed'

  post 'main/show_cert_verification'



  resources :regular_certificates
  resources :root_certificates
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
