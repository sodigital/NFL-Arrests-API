class CreateArrests < ActiveRecord::Migration
  def change
    create_table :arrests do |t|
      t.date :date
      t.string :team
      t.string :name
      t.string :pos
      t.string :arest_or_charge  
      t.string :category
      t.string :description
      t.string :outcome

      t.timestamps
    end
  end
end
