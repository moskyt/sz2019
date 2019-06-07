class Admin::AdminController < ApplicationController

  layout "admin"
  
  before_action :http_basic_authenticate

  def http_basic_authenticate
    authenticate_or_request_with_http_basic do |name, password|
      name == 'zelena' && password == 'modra'
    end
  end
  
end
