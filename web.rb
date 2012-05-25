
require 'sinatra'

get "/" do
  erb :index, :layout => :layout
end