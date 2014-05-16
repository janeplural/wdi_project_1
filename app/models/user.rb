class User < ActiveRecord::Base

  include BCrypt

  validate :email, uniqueness: true

  has_many :readrs
  has_many :pieces, through: :readrs

  def password= password_input
  	new_password_hash = Password.create(password_input)
  	self.hashed_password = new_password_hash
  	self.hashed_password
  end

  def password
  	Password.new(self.hashed_password)
  end

  def check_password(passowrd_input)
  	password_input == self.password
  end

  def self.authenticated?(email_input, passowrd_input)
  	user = User.find_by_email(email_input)
  	  if user && user.password == password_input
  	    return user
  	  else
  	    puts "Couldn't authenticate!"
  	    return nil
  	  end
  	  puts "Did not find email."
  	  return nil
  end

end
