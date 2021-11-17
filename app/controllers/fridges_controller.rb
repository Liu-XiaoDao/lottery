class FridgesController < ApplicationController
  layout 'template'

  def index
    @fridges = Fridge.all.paginate page: params[:page], per_page: 50
  end
end
