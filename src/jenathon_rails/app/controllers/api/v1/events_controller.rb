module Api::V1
  class EventsController < BaseController

    before_action :set_event, only: [:show, :edit, :update, :destroy]

    # GET /events
    # GET /events.json
    def index

      # placeholder search string
	      search_conditions = []

      # check for search params
      if params.key?(:max_date_time)
        # set search condition
	      search_conditions.push("targeted_at > ?")

		    # get events for user only, + search conditions
        events = Event.where(search_conditions.join(" and "), Time.zone.now)
      else
        events = Event.all
      end

      #check if result exists
      if(events)
        #respond existingsearch result
        render json: events, status: 200
      else
        head 404
      end
    end

    # GET /events/1
    # GET /events/1.json
    def show
      render json: @event, status: 200
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
      @event = Event.new(event_params)

      if @event.save
        render json: @event, status: 201
      else
        render json: { errors: @event.errors }, status: 422
      end
    end

    # PATCH/PUT /events/1
    # PATCH/PUT /events/1.json
    def update
      if @event.update(user_params)
        render json: @event, status: 200
      else
        render json: { errors: @event.errors }, status: 422
      end
    end

    # DELETE /events/1
    # DELETE /events/1.json
    def destroy
      @event.destroy
      head 204
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_event
        @event = Event.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def event_params
        params.require(:event).permit(:latitude, :longitude, :title, :description, :category, :targeted_at, :address)
      end
  end
end