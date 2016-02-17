require 'pry'
require 'exifr' 
require 'gmaps4rails'

class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update]
  protect_from_forgery with: :null_session

  # GET /events
  # GET /events.json
  def index
    @events = Event.where({ user_id: current_user.id }).order(created_at: :desc)
    @invitations = EventUser.where({ number: current_user.phone }).map { |invite| invite.event }
    
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params['id'])
    session[:last_event] = @event.id
    # @event = Event.find(params['id'])
    @invites = EventUser.where(event_id: params['id'].to_i)
    @invites = @invites.where.not(accepted: false)
    @new_invite = EventUser.new
    @event_place_id = @event.place_id

    @invites.each { |invite|
      invite.user.eta(invite)
    }

    @event.user.host_eta(@event)
    markers = [@event, @event.user].concat(@invites)
    markers.reject! do |obj|
      if obj.class.name === 'Event' || obj.class.name == 'User'
        !obj.latitude || !obj.longitude 
      elsif obj.class.name == 'EventUser'
        !obj.user.latitude || !obj.user.longitude 
      end
    end

    @hash = Gmaps4rails.build_markers(markers) do |obj, marker|
      if obj.class.name === 'Event'
        event = obj
        marker.lat event.latitude
        marker.lng event.longitude
        marker.picture({
          anchor: [40, 80],
          url: "#{view_context.image_path('/assets/precious.png')}",
          width: 44,
          height: 80
        })
        # marker.infowindow event.title
        marker.infowindow event.title

        current_user.local_ip = request.remote_ip
        current_user.save()
      elsif obj.class.name === 'EventUser'
        invite = obj
        @user = invite.user
        @invite = invite
        user_photo = @user.prof_img_url
        user_event_eta = @invite.eta
        user_full_name = @user.name
        marker.lat @user.latitude
        marker.lng @user.longitude
        marker.picture({
          url: "#{view_context.image_path('<%= user_photo %>')}",
          width: 44,
          height: 80
        })

        marker.infowindow render_to_string("events/marker_infowindow", :layout => false, locals: { user: @user, invite: invite })
      elsif 
        @user = obj

        if @user.prof_img_url == ""
          user_photo = "/assets/magician.png"
        else
          user_photo = @user.prof_img_url
        end
        # user_event_eta = @invite.eta
        user_full_name = @user.name
        marker.lat @user.latitude
        marker.lng @user.longitude
        
        marker.picture({
          url: "#{user_photo}",
          width: 44,
          height: 80
        })

        

        marker.infowindow render_to_string("events/marker_infowindow", :layout => false, locals: { user: @user, invite: @event })     
      end
    end
  end

  # GET /events/new
  def new
    if current_user == nil
      @force_redirect = true
      render 'users/login' 
    else
    @event = Event.new
    end
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
    ev_params[:latitude] = ev_params[:latitude].to_f
    ev_params[:longitude] = ev_params[:longitude].to_f
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
    @event = Event.find(params[:id])
    @event.destroy
    render :nothing => true, :status => 200, :content_type => 'text/plain'
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
      if current_user != nil
        @event = Event.find(params[:id])
      else
        redirect_to('/login?force=true')
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :caption, :time_at, :event_img_url, :longitude, :latitude, :photo)
    end

    def invite_params
      params.require(:event_user).permit(:number, :event_id)
    end
end
