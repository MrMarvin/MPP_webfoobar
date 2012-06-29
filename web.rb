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
  cat = params[:cat].gsub(" ","")
  page = params[:page].gsub(" ","")
  if File.exist?("views/"+cat+"/"+page+".erb")
    erb (cat+"/"+page).to_sym, :layout => false
  else
    halt 404, "gibts nicht!"
  end

end