# encoding: utf-8

class Mppcms

  attr_accessor :pages
  
  PAGES_PATH = "views/"
  HASH_OF_SUPER_SECRET_KEY = "528d0eda1d61244a55b49f39fcb6140e89a03986" # 100x SHA1 of "geheim"
  
  def initialize
    @pages = {
      "Heim" => {:subpages => ["Über dieses Projekt", "Seitenkarte","API Informationen", "Impressum"], :color => "#218ec6"},
      "Ruby" => {:subpages => ["Die Sprache","Von Schienen und Bühnen","Hypertextverweise"], :color => "#B41010"},
      "Hypermedia" => {:subpages => ["Hervorhebungssprachen","Verweise"], :color => "#abc820"},
      "JavaScript" => {:subpages => ["JQuery", "AJAX","andere Gemeinheiten"], :color => "#f09d27"}
      }
  end

  def authorize(key)
    require 'Digest'

    100.times do 
      key = Digest::SHA1.hexdigest(key)
    end
    authorized?(key) ? key : false
  end

  def authorized?(hash_of_key)
    HASH_OF_SUPER_SECRET_KEY == hash_of_key
  end

  def sanatize(forwhat)
    cat, page = forwhat.split("/")
     raise SecurityError, "can i haz no traversal plz" if forwhat.split("/").length != 2  or cat == ".." or page == ".."
  end
  
  def get_source_for(forwhat) 
    sanatize forwhat
    (File.read PAGES_PATH+forwhat+".erb").strip # strip \n and stuff
  end
  
  def post_source_for(forwhat, content)
    sanatize forwhat
    cat, page = forwhat.split("/")
    Dir.mkdir PAGES_PATH+cat unless File.exists? PAGES_PATH+cat
    File.open PAGES_PATH+forwhat+".erb", "w" do |f|
      f.puts content
    end
  end
    
end