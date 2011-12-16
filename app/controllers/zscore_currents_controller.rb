class ZscoreCurrentsController < ApplicationController
  def index
    @terms = Term.order_by_current_zscore
  end

end
