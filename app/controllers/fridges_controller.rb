class FridgesController < ApplicationController
  layout 'template'
  http_basic_authenticate_with name: "abid_admin", password: "Abcam123"

  def index
    @fridges = Fridge.all.paginate page: params[:page], per_page: 50
  end
end
