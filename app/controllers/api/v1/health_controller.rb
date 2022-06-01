class Api::V1::HealthController < ApplicationController

  def index
    success_response(nil, 'Welcome to Rails App!!!')
  end
  
end