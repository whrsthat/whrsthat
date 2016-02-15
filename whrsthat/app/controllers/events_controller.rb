require 'pry'
require 'exifr' 
require 'gmaps4rails'

class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.where({ user_id: current_user.id })
    @invitations = EventUser.where({ number: current_user.phone }).map { |invite| invite.event }
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event_location = Event.find(params['id'])
    @event = Event.find(params['id'])
    @invites = EventUser.where(event_id: params['id'].to_i)
    @new_invite = EventUser.new
    @hash = Gmaps4rails.build_markers(@event_location) do |event, marker|

      marker.lat event.latitude
      marker.lng event.longitude
      marker.picture({
                    url: "#{view_context.image_path('/assets/precious.png') }",
                    width: "44",
                    height: "90"
     })
      marker.infowindow event.title

      #get event users from table
      #if they have accepted event invite 
      #get their info from users table using user id
      #user lat long

      #current_user.local_ip = open('http://ifconfig.me/ip').read.gsub("\n", "")
      #current_user.save()
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

    ev_params[:time_at]  = Time.parse(ev_params[:time_at])
    ev_params[:user_id] = current_user.id
    @event = Event.new(ev_params, params[:event][:photo])

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

  def invite 
    in_params = invite_params.clone
    @event = Event.find(params['id'])
    in_params['event_id'] = @event.id
    @new_invite = EventUser.new(in_params)
    @new_invite.save()
    @invites = EventUser.where(event_id: params['id'].to_i)
    render :show
  end

  def invite_destroy 
    invite = EventUser.find(params['invite_id'])
    invite.destroy

    render :nothing => true, :status => 200, :content_type => 'text/plain'
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

    def invite_params
      params.require(:event_user).permit(:number, :event_id)
    end
end
