class WelcomeController < ApplicationController
 
  def index
 
  end

  def query
    injection = params[:q]
    
    if Rails.env.production?
      @arrests  = Arrests.where(" (team ilike '%#{injection}%' OR name ilike '%#{injection}%' OR pos ilike '%#{injection}%' OR arest_or_charge ilike '%#{injection}%' OR category ilike '%#{injection}%' OR description ilike '%#{injection}%'  OR outcome ilike '%#{injection}%')")
    else
      @arrests  = Arrests.where(" (team like '%#{injection}%' OR name like '%#{injection}%' OR pos like '%#{injection}%' OR arest_or_charge like '%#{injection}%' OR category like '%#{injection}%' OR description like '%#{injection}%'  OR outcome like '%#{injection}%')")
    end




    render json: {
        records: @arrests
    }


  end

  def nfl_arrests_api
    
  end
end
