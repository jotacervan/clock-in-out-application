class UserController < ApplicationController
  respond_to :json
  before_action :authenticate_user!
  before_action :get_user, only: [:show, :update, :destroy]

  def create
    @user = User.create!(user_params)
    if @user.persisted?
      render json: @user, status: :created
    else
      render json: { message: 'Error creating user' }, status: 402
    end
  end

  def show
    render json: @user, status: :ok
  end

  def update
    @user.update(user_params)

    render json: @user, status: :ok
  end

  def destroy
    @user.destroy
    render json: {}, status: :ok
  end

  private
    def get_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :hours_per_week)
    end
end
