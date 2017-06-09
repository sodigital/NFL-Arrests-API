namespace :arrests do
  desc "Seeds all arrest records from http://www.usatoday.com/sports/nfl/arrests"
  task seed_arrests: :environment do
   
    # WHY so bad
    #THIS UPDATES the data.json file son
    url         = "https://api.import.io/store/connector/a373c20d-1a7e-4854-8483-fd30d1934cdf/_query?input=webpage/url:http%3A%2F%2Fwww.usatoday.com%2Fsports%2Fnfl%2Farrests%2F&&_apikey=4a81e22502b6463b917cbfa29f7b35cc2f244b04b77cce1a8f7340feecd07a787f7bd56dd8e621d1bf687438b9300b97e5e294b6e17c669a8197161695274c47c1ac842c7c59ae1192736bd633f6777a" 
    puts "WORKING"
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
      puts "in loop #{r}"
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
