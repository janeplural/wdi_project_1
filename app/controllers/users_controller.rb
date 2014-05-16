class UsersController < ApplicationController

  def index
  	@users = User.all
  end

  def show
  	@user = User.find(params[:id])
  end

  def new 
  	@user = User.new
  end

  def create
  	user_hash = params[:user]
    if user_hash[:password] == user_hash[:password_confirmation]
      user = User.new
      user.password = user_hash[:password]
      user.name = user_hash[:name]
      user.email = user_hash[:email]
      user.save

      if user.valid?
        @current_user = user
        redirect_to "/user/login"
      else
        render text: "Email is already taken!"
      end
    else
      render text: "Passwords did not match!"
    end
    #for testing
    render json: params 
  end

  #omar says it's not super RESTful, where should it go?
  def login

  end

  def process_login
    email = params[:email]
    password = params[:password]
    @current_user = User.authenticaed?(email, password)

    if @current_user
      redirect_to "/users/:id"
    else
      rend text: "Login Failed! Invalid email or password."
    end
  end
  
end
