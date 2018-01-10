class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def json_users
		@users = User.all
		render json: {info:@users}
	end
end
