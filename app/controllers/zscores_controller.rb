class ZscoresController < ApplicationController
  def index
  end

  def show
    
    @zscores = Term.find(params[:id]).zscores
    @term = Term.find(params[:id])
  end

end
