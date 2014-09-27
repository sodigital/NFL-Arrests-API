namespace :arrests do
  desc "Seeds all arrest records from http://www.usatoday.com/sports/nfl/arrests"
  task seed_arrests: :environment do
    _file   =  File.read("public/data.json")
    json = JSON.parse(_file) 
   
    json.each do |x|
      d = Date.strptime(x["DATE"], "%m/%d/%y")
      Arrests.create date: d,  team: x["TEAM"], name: x["NAME"], pos: x["POS"], arest_or_charge: x["CASE"], category: x["CATEGORY"], description: x["DESCRIPTION"], outcome: x["OUTCOME"]
    end
    



  end


end
