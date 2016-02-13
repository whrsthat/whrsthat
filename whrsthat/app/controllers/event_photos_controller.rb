class EventPhotosController < ApplicationController
  before_action :set_event
  before_action :set_event_photo, only: [:show, :edit, :update, :destory]

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_event_photo
    @event_photo = EventPhoto.find(params[:id])
  end

  def index
  	@event_photos = Event_photo.all 
  end

  def new
  	@event_photo = Event_photo.new
  end

  def create
  	@event_photo = Event_photo.new(event_photo_params)

  	if @event_photo.save
  		redirect_to event_photos_path, notice: "Your amazing picture has been uploaded!"
  	else 
  		render "new"
  	end
  end

  def destroy
  	@event_photo  = Event_photo.find(params[:id])
    @event_photo.destroy
    redirect_to event_photos_path, notice: "Picture deleted. Upload another great one."
  end

  private
  def event_photos_params
    params.require(:event_photo).permit(:attachment, :file)
  end
end
