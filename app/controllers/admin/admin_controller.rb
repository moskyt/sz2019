class Admin::AdminController < ApplicationController

  http_basic_authenticate_with name: "zelena", password: "modra"

  layout "admin"
  
end
