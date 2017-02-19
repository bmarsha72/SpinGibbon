class AccountController < ApplicationController

  get '/' do
    #login registration page
  end

  post '/register' do
    #accept params from a post to create a user (bcrypt)
    #these are all the fields in the database table coming from
    #params as a post from the page
    @username = params[:username]
    @password = params[:password]
    @email = params[:email]
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @liberal = params[:liberal]
    @moderate = params[:moderate]
    @conservative = params[:conservative]

    if does_user_exist?(@username) == true
      @account_message = "User already exists"
      return erb :login_notice
    end

    password_salt = BCrypt::Engine.generate_salt
    password_hash = BCrypt::Engine.hash_secret(@password, password_salt)

    #new model(new account create in the model(from params to variables to here to the db)
    @model = Account.new
    @model.username = @username
    @model.email = @email
    @model.first_name = @first_name
    @model.last_name = @last_name
    @model


  end

  post '/login' do
    #check params if user exists and if so, log them in
    @username = params[:username]
    @password = params[:password]
    @email = params[:email]
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
