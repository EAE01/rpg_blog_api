class Api::V1::UsersController < ApplicationController
  def index
    users = User.offset(params[:offset] || 0).limit(params[:limit] || false)
    render json: users
  end

  def create
    user = User.create(user_params)
    if user.valid?
      render json: user
    else
      render json: user.errors
    end
  end

  def show
    user = User.find_by(id: params[:id])
    if user
      render json: user
    else
      render json: {}
    end
  end

  def update
    user = User.find_by(id: params[:id])
    if user
      if user.update(editable_params)
        render json: user
      else
        render json: user.errors
      end
    else
      render json: {}
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :username,
      :email,
      :password
    )
  end

  def editable_params
    params.require(:user).permit(
      :username,
      :password
    )
  end
end