class EventsController < ApplicationController
  def index
  	@event = Event.all
  end

  def new
  	
  end

  def show
    @event = Event.find(params[:id])
    
  end

  def create

  	@event = Event.create(start_date: params[:start_date], duration: params[:duration], title: params[:title], description: params[:description], price: params[:price], location: params[:location], admin_id: current_user.id )
  	redirect_to root_path
  end
end
