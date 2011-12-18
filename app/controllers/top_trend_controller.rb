class TopTrendController < ApplicationController
  def index
    @top_20 = ZscoreCurrent.top_20
    
  end

end
