class EventsController < ApplicationController
  def index
  	@users = User.joins(:location).where(id: session[:user_id]).select("users.id as user_id", :first_name, :last_name, :email, "locations.id as location_id", "locations.city as city", "locations.state as state")
  	@events = Event.joins(:location).joins(:user).select("*")
  	# @user_events = Join.find_by(user_id: session[:user_id])
  end

  def create
  	location = Location.find_by(sanitize_location)
  	if location 
  		event = Event.new(sanitize_event)
  		event.location_id = location.id
  		event.user_id = session[:user_id]
  		event.save
  	else
  		locate = Location.new(sanitize_location)
  		locate.save
  		event = Event.new(sanitize_event)
  		event.location_id = locate.id
  		event.user_id = session[:user_id]
  		event.save
  	end	
  	redirect_to events_path
  end

  private 
  	def sanitize_event
  		params.require(:event).permit(:name, :event_date)	
  	end

  	def sanitize_location
		params.require(:location).permit(:state, :city)
	end
end
  		
