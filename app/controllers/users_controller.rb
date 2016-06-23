class UsersController < ApplicationController
	def index 
	end

	def edit
		@user = User.joins(:location).where(id: session[:user_id]).select('*').limit(1)
	end

	def new
	end

	def update
		temp_location = Location.find_by(sanitize_location)
		if(temp_location)
			# user = User.new(sanitize_user, location: temp_location[:id])
			user = User.find(session[:user_id])
			user.location_id = temp_location.id
			user.update(sanitize_user)
		else 
			location1 = Location.new(sanitize_location)
			location1.save
			#validations later
			user = User.find(session[:user_id])
			user.location_id = location1.id
			user.update(sanitize_user)
		end
		redirect_to "/events"
	end
	def create
		temp_location = Location.find_by(sanitize_location)
		if(temp_location)
			# user = User.new(sanitize_user, location: temp_location[:id])
			user = User.new(sanitize_user)
			user.location_id = temp_location.id
			user.save
		else 
			location1 = Location.new(sanitize_location)
			location1.save
			#validations later
			user = User.new(sanitize_user)
			user.location_id = location1.id
			user.save
		end
		session[:user_id] = User.last.id
		redirect_to "/events"
	end
	def show
		user = User.find(params[:id])
	end

	private
	def sanitize_user
		params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
	end

	def sanitize_location
		params.require(:location).permit(:state, :city)
	end

end
