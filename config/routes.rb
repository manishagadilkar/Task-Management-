# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tasks, only: [:index, :show, :create, :update, :destroy] do

      # resources :tasks do
        member do
          patch 'mark_done'
        end
      end
    end
  end
end