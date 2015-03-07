namespace :arrests do
  desc "Seeds all arrest records from http://www.usatoday.com/sports/nfl/arrests"
  task seed_arrests: :environment do
   

    #THIS UPDATES the data.json file son
    url         = "https://api.import.io/store/data/5f33633c-54b7-41c7-971b-9f89770d6db2/_query?input/webpage/url=http%3A%2F%2Fwww.usatoday.com%2Fsports%2Fnfl%2Farrests%2F&_user=4a81e225-02b6-463b-917c-bfa29f7b35cc&_apikey=LyRLBLd8zhqPc0D%2B7NB6eH971W3Y5iHRv2h0OLkwC5fl4pS24XxmmoGXFhaVJ0xHwayELHxZrhGSc2vWM%2FZ3eg%3D%3D" 
    data        = HTTParty.get(url) 
    results     = data["results"]
    new_results = []
    # ex: key_matching["bad_key"] returns new key
    key_matching = {
      "date_text"    => "DATE",
      "text_1"       =>  "TEAM",
      "name_text"    => "NAME",
      "text_2"       => "POS",
      "text_3"       => "CASE",
      "text_4"       => "CATEGORY",
      "text_5"       => "DESCRIPTION",
      "outcome_text" => "OUTCOME"
    }
    results.each  do |r|
      newhash = Hash[r.map {|k, v| [key_matching[k], v] }]
      new_results << newhash
    end

    #save that file son
    File.open("public/data.json","w") do |f|
        f.write(new_results.to_json)
    end 

    #THIS IMPORTS THE DATA SON
    _file   =  File.read("public/data.json")
    json = JSON.parse(_file) 
   
    #kill the db lol this is sketchy and stupid
    Arrests.delete_all 
    #
    json.each do |x|
      # d = Date.strptime(x["DATE"], "%m/%d/%y")
      Arrests.create date: x["DATE"],  team: x["TEAM"], name: x["NAME"], pos: x["POS"], arest_or_charge: x["CASE"], category: x["CATEGORY"], description: x["DESCRIPTION"], outcome: x["OUTCOME"]
    end
    



  end


end
