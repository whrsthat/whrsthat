class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json

  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def set_session(user)
    session[:user_name] = user.email
    @name = session[:user_name]
  end

  # POST /users
  # POST /users.json
  def create
    tmp_obj = JSON.parse(JSON.generate(user_params))
    tmp_obj['password'] = params['password']
    @user = User.new( tmp_obj )
    respond_to do |format|
      if @user.save
        set_session @user
        format.html { render 'events/index', notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def login
    user = User.find_by(email: params['email'])
      # checks the db for a user that matches the name submitted.

    if user && user.authenticate(params['password'])
      #if user exists and password is legit then.....
      set_session user

      render 'events/index'

    else
      @error = true
      render :home
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:phone, :fname, :lname_initial, :email, :password_digest, :prof_img_url)
    end
end
