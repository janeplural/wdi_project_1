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
    @user = User.find(params[:id])
    #works for login
     # cu_id = current_user.id
     # @user = User.find(@current_user.id)

  end

# put in welcome_controller to make it more restful
  # def new 
  # 	@user = User.new
  # end

# also moving to welcome_controller for RESTfulness
#   def create
#   	user_hash = params[:user]
#     if user_hash[:password] == user_hash[:password_confirmation]
#       user = User.new
#       user.password = user_hash[:password]
#       user.name = user_hash[:name]
#       user.email = user_hash[:email]
#       user.save

#       if user.valid?
#         @current_user = user
#         redirect_to "/user/login"
#       else
#         render text: "Email is already taken!"
#       end
#     else
#       render text: "Passwords did not match!"
#     end
#     #for testing
#     render json: params 
#   end

  #omar says it's not super RESTful, where should it go?
  # def login

  # end



end
