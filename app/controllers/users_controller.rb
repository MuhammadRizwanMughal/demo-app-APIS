class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :create_token, only: [:create]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params.merge(authentication_token: @random_token))
    @user.password = encrypt_token(@user.password)
    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by_authentication_token(request.headers['Authorization'])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

  def create_token
    loop do
      @random_token = SecureRandom.urlsafe_base64(nil, false)
      break @random_token unless User.exists?(authentication_token: @random_token)
    end
  end
end
