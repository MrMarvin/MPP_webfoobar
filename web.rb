# encoding: utf-8

require 'sinatra'
require './mppcms'

before do
  @cms = Mppcms.new
end

get "/" do
  erb :index, :layout => :layout
end