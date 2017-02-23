require 'sinatra/base'

#controllers
require './controllers/application_controller'
require './controllers/source_controller'
require './controllers/account_controller'


#models
require './models/account'
require './models/source'



#map controllers
map('/') { run ApplicationController }
map('/account') { run AccountController }
