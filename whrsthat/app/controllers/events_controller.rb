require 'pry'
require 'exifr' 


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
    @address = Event.find(params['id'])
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
    event_p = JSON.parse(JSON.generate(event_params))
    @event = Event.new(event_p)

    respond_to do |format|
      # tempfile = params[:event][:photo]
      
      if @event.save

        # file = File.open('./public/IMG_3503.JPG')
        photo = EXIFR::JPEG.new(tempfile.path)
        
        google_server_key = ENV["GOOGLE_SERVER_KEY"];
        lat = photo.exif[0].gps_latitude[0].to_f + (photo.exif[0].gps_latitude[1].to_f / 60) + (photo.exif[0].gps_latitude[2].to_f / 3600)
        long = photo.exif[0].gps_longitude[0].to_f + (photo.exif[0].gps_longitude[1].to_f / 60) + (photo.exif[0].gps_longitude[2].to_f / 3600)
        long = long * -1 if photo.exif[0].gps_longitude_ref == "W"   # (W is -, E is +)
        lat = lat * -1 if photo.exif[0].gps_latitude_ref == "S"      # (N is +, S is -)

        lat_to_string = lat.to_s
        long_to_string = long.to_s

        google_uri = URI("https://maps.googleapis.com/maps/api/geocode/json?latlng=#{lat_to_string},#{long_to_string}&key=#{google_server_key}")
        result = Net::HTTP.get(google_uri)
        photo_data = JSON.parse(result)
        @@address = photo_data.flatten[1][0]["formatted_address"] # save to db

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
