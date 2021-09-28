Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # API
  # TODO: add routes

  # Delegate to Vue
  root 'vue#index'
  match '*path', to: 'vue#index', format: false, via: :get, constraints: lambda { |req|
    req.path.exclude?('rails/active_storage')
  }
end
