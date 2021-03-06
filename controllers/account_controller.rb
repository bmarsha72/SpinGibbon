class AccountController < ApplicationController

  get '/' do
    #login registration page
    erb :login, layout: :layout
  end

  post '/register' do
    #accept params from a post to create a user (bcrypt)
    #these are all the fields in the database table coming from
    #params as a post from the page
    # @username = params[:username]
    # @password = params[:password]
    # @email = params[:email]
    # @first_name = params[:first_name]
    # @last_name = params[:last_name]
    # @liberal = params[:liberal]
    # @moderate = params[:moderate]
    # @conservative = params[:conservative]

    if does_user_exist?(@username) == false
      @account_message = "User already exists"
      return erb :login_notice
    end

    # password_salt = BCrypt::Engine.generate_salt
    # password_hash = BCrypt::Engine.hash_secret(@password, password_salt)
    password_hash = BCrypt::Password.create(params[:password])

    #new model(new person) created (from params
    #to variables to here to the db)
    @model = Account.new(username: params[:username], email: params[:email], first_name: params[:first_name], last_name: params[:last_name], liberal: params[:liberal], moderate: params[:moderate], conservative: params[:conservative], password_hash: password_hash)
    # @model.username = @username
    # @model.email = @email
    # @model.first_name = @first_name
    # @model.last_name = @last_name
    # @model.liberal = @liberal
    # @model.moderate = @moderate
    # @model.conservative = @conservative
    # @model.password_hash = password_hash
    # @model.password_salt = password_salt
    @model.save

    @account_message = "you have successfully registered and are logged in!"

    #this means that when they have registered, they are also logged in:
    session[:user] = @model

    erb :login_notice

  end

  post '/login' do
    #check params if user exists and if so, log them in
    @username = params[:username]
    @password = params[:password]
    @email = params[:email] #optional

    if does_user_exist?(@username) == true
      @account_message = "User Already Exists"
      return erb :login_notice
    end

    #could also use Account.find...
    @user = Acccount.find_by(username: params[:username])
    
    #if password provided matches the password provided along with the salt that's in the db:
    if @model.password_hash == BCrypt::Engine.hash_secret(@password, @model.password_salt)
      @account_message = "Welcome Back!"
      #make the session user(the person who is signed in) equal to the person (the @model)
      session[:user] = @model
      return erb :login_notice
    else
      @account_message = "Sorry, your password did not match.  Try again?"
      return erb :login_notice
  end

  get '/logout' do
    #user peaces out
    #will need to login again
    session[:user] = nil
    redirect '/'
  end

  get '/supersecret' do
    #test of user authentication. Show only to registered,
    #logged-in users

  end
end
end
