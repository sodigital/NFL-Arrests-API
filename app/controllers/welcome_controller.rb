class WelcomeController < ApplicationController
 
  def index
 
  end

  def query
    injection = params[:q]
    @arrests  = Arrests.where(" (team LIKE '%#{injection}%' OR name LIKE '%#{injection}%' OR pos LIKE '%#{injection}%' OR arest_or_charge LIKE '%#{injection}%' OR category LIKE '%#{injection}%' OR description LIKE '%#{injection}%'  OR outcome LIKE '%#{injection}%')")

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
