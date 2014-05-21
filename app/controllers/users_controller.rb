class UsersController < ApplicationController

before_action :authenticate_with_basic_auth

  def index
   redirect_to "/users/#{@current_user.id}"
  end

  def login  
  end

  def show
    # def add
    #     render partial: "userform", locals: { user: current_user }
    #   end
    # end
  end

  def process_login
    email = params[:email]
    password = params[:password]
    @current_user = User.authenticated?(email, password)

    if @current_user
      # binding.pry
      # id = current_user.id
      redirect_to "/users/#{@current_user.id}"
      # redirect_to user_path(current_user)
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
