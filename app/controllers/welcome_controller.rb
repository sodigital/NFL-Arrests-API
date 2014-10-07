class WelcomeController < ApplicationController
 
  def index
 
  end

  def query
    injection = params[:q]
    @arrests  = Arrests.where(" (team ilike '%#{injection}%' OR name ilike '%#{injection}%' OR pos ilike '%#{injection}%' OR arest_or_charge ilike '%#{injection}%' OR category ilike '%#{injection}%' OR description ilike '%#{injection}%'  OR outcome ilike '%#{injection}%')")

    render json: {
        records: @arrests,
      #   pager: {
      #     tota: @arrests.count
      # }
    }


  end

  def nfl_arrests_api
    
  end
end
