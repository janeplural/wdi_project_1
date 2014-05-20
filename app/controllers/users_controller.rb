class UsersController < ApplicationController

before_action :authenticate_with_basic_auth

  def index
   redirect_to "/users/#{@current_user.id}"
  end

  def login  
  end

  def process_login
    email = params[:email]
    password = params[:password]
    @current_user = User.authenticated?(email, password)

    if @current_user
      # binding.pry
      # id = current_user.id
      redirect_to "/users/#{@current_user.id}"
      # redirect_to "/users/:id"
    else
      render text: "Login Failed! Invalid email or password."
    end
  end

  def show
    #works for signup
    # @user = User.find(params[:id])
    #works for login
     # cu_id = current_user.id
     # @user = User.find(@current_user.id)
  end

end
