class WelcomeController < ApplicationController

 def index
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
        #original code
        # @current_user = user
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

 def login
 	# redirect_to "/users/login"
 end

 # def process_login
 # 	email = params[:email]
 # 	password = params[:password]
 # 	@current_user = User.authenticated?(email, password)

 # 	if @current_user
 # 		redirect_to "/users/:id"
 # 	else
 # 		render text: "Login Failed! Invalid email #{email} or password #{password}."
 # 	end
 # end

end