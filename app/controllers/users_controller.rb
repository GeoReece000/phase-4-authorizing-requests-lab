class UsersController < ApplicationController

  def show
    user = User.find(session[:user_id])
    render json: user
  end

  def user_signed_in?
    session[:user_id].present?
  end


end
