require 'pry'
require 'exifr' 
require 'gmaps4rails'

class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @users_current_location = Event.find(params['id'])
    @hash = Gmaps4rails.build_markers(@users_current_location) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.picture({
                    anchor: [40, 58], # added this optionally <- doesn't work either
                    url: "#{view_context.image_path("http://people.mozilla.com/~faaborg/files/shiretoko/firefoxIcon/firefox-32.png") }",
                    width: "44",
                    height: "58"
     })
      marker.infowindow user.title
    end
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    ev_params = event_params.clone
    @event = Event.new(ev_params)

    respond_to do |format|
      # tempfile = params[:event][:photo]
      
      if @event.save

        # file = File.open('./public/IMG_3503.JPG')

        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }

      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event    
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :caption, :time_at, :event_img_url, :lng, :lat, :photo)
    end
end
