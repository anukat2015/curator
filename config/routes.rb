Rails.application.routes.draw do
  root 'welcome#index'

  get "/#{ENV['SECRET_URI']}", to: 'reports#get_reports'
end
