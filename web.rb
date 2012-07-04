# encoding: utf-8

require 'sinatra'
require 'sinatra/cookies'
require 'sinatra/namespace'
require './mppcms'

before do
  @cms = Mppcms.new
end

get "/" do
  erb :index
end

get "/auth/:token" do  
  hash_of_key = @cms.authorize params[:token]
  if hash_of_key
    cookies[:mppminicmsauth] = hash_of_key
    redirect "/"
  else
    halt 403, "nein, falsch!"
  end    
end

get "/deauth" do
    cookies[:mppminicmsauth] = nil
    redirect "/"
end

get "/:cat/:page" do
  cat = params[:cat].gsub(" ","")
  page = params[:page].gsub(" ","")
  
  begin    
    erb @cms.get_source_for(cat+"/"+page), :layout => false
  rescue Errno::ENOENT
    if @cms.authorized? cookies[:mppminicmsauth]
      halt 200, "NEUE SEITE MUSS ERST ANGELEGT WERDEN!"
    else
      halt 404, "gibt es nicht!"
    end
  end
end

namespace "/source" do

  before do
    halt 403, "anmelden erst, du musst!" unless @cms.authorized? cookies[:mppminicmsauth]
  end
      
  get "/:cat/:page" do
    cat = params[:cat].gsub(" ","")
    page = params[:page].gsub(" ","")

      # faking a layout around the plaintext to avoid erb rendering of source
      buff = (erb :editor, :layout => false)
      begin  
        buff = buff + @cms.get_source_for(cat+"/"+page)
      rescue Errno::ENOENT
        buff = buff+'<h1>NEUE SEITE</h1>'
      end
      buff = buff+'</textarea> </form>'
      
      buff
  end

  post "/:cat/:page" do
    cat = params[:cat].gsub(" ","")
    page = params[:page].gsub(" ","")

    begin
      @cms.post_source_for(cat+"/"+page, params[:source])
      redirect "#"+cat+"/"+page
    rescue Errno::ENOENT => e
      halt 500, e.message
    end    
  end

end

