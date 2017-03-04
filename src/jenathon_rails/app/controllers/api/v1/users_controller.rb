module Api::V1
  class UsersController < BaseController

    before_action :set_user, only: [:show, :edit, :update, :destroy]

    # GET /users
    # GET /users.json
    def index
      target_user = User.all

      #check if result exists
      if(target_user)
        #respond existingsearch result
        render json: target_user, status: 200
      else
        head 404
      end
    end

    # GET /users/1
    # GET /users/1.json
    def show
      render json: @user, status: 200
    end

    # GET /users/new
    def new
      @user = User.new
    end

    # GET /users/1/edit
    def edit
    end

    # POST /users
    # POST /users.json
    def create
      @user = User.new(user_params)

      if @user.save
        render json: @user, status: 201
      else
        render json: { errors: @user.errors }, status: 422
      end
    end

    # PATCH/PUT /users/1
    # PATCH/PUT /users/1.json
    def update
      if @user.update(user_params)
        render json: @user, status: 200
      else
        render json: { errors: @user.errors }, status: 422
      end
    end

    # DELETE /users/1
    # DELETE /users/1.json
    def destroy
      @user.destroy
      head 204
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def user_params
        params.require(:user).permit(:latitude, :longitude, :address, :description, :title)
      end
  end
end
