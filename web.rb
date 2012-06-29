# encoding: utf-8

require 'sinatra'
require './mppcms'

before do
  @cms = Mppcms.new
end

get "/" do
  erb :index
end

get "/:cat/:page" do
  cat = params[:cat]
  page = params[:page]
  erb (cat+"/"+page).to_sym, :layout => false
end
  