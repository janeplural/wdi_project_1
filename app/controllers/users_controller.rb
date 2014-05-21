class UsersController < ApplicationController

before_action :authenticate_with_basic_auth, except: [:new, :create]

  def index
   redirect_to "/users/#{@current_user.id}"
  end

  def login  
  end

  def show
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

      if User.find_by_email(user.email) == nil
        user.save

        redirect_to "/users/#{user.id}"
      else
        render text: "Email is already taken!"
      end

    else
      render text: "Passwords did not match!"
    end
    #for testing
    # render json: params 
  end

  def process_login
    email = params[:email]
    password = params[:password]
    @current_user = User.authenticated?(email, password)

    if @current_user
      # binding.pry
      # redirect_to "/users/#{@current_user.id}"
      redirect_to user_path(current_user.id)
    else
      render text: "Login Failed! Invalid email or password."
    end
  end

  def edit
    render partial: "userform", locals: { user: current_user }
  end

  def update
    user = User.find("#{current_user.id}")
    user.update_attributes(user_attributes)
    
    redirect_to "/users/#{current_user.id}"
  end

  private

    def user_attributes
      params.require(:user).permit(:name, :email)
    end


end
