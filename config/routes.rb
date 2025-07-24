RailsStarter::Application.routes.draw do
  # Health check endpoint
  get '/health' => 'application#health'
  
  # Metrics endpoint for Prometheus
  get '/metrics' => 'metrics#index'
  
  # Root route
  root :to => 'say#hello'
end
