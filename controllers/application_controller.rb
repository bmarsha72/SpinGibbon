class ApplicationController < Sinatra::Base

  @account_message = ""

  #bundles our gems together...
  require 'bundler'
  Bundler.require

  ActiveRecord::Base.establish_connection(
      :adapter => 'mysql2',
      :database => 'spinhappy'
  )

  set :public_folder, File.expand_path('../public', __FILE__)
  set :views, File.expand_path('../views', __FILE__)
  enable :sessions

  not_found do
    erb :not_found #404 page
  end

  def does_user_exist?(username)
    user = Account.find_by(:username => username.to_s)
    if user
      return true
    else
      return false
    end
  end

  def is_not_authenticated
    session[:user].nil? #bool
  end

  get '/' do
    {:message => 'HELLO GRAHAM'}.to_json
  end





  


end
