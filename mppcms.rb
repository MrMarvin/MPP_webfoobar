# encoding: utf-8

class Mppcms

  attr_accessor :pages
  
  def initialize
    @pages = {
      "Heim" => {:subpages => ["Über dieses Projekt", "Seitenkarte","API Informationen", "Impressum"], :color => "#218ec6"},
      "Ruby" => {:subpages => ["Die Sprache","Von Schienen und Bühnen","Hypertextverweise"], :color => "#B41010"},
      "Hypermedia" => {:subpages => ["Hervorhebungssprachen","Verweise"], :color => "#abc820"},
      "JavaScript" => {:subpages => ["JQuery", "AJAX","andere Gemeinheiten"], :color => "#f09d27"}
      }
  end
  
    
end