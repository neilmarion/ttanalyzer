class ZscoreHistorical < ActiveRecord::Base
  belongs_to :term

  def ave(plus_n)
    self.sum.to_f/(self.n.to_f + plus_n.to_f)
  end

  def std(plus_n)
    #(Math.sqrt((term.zscore_historical.sqr_total.to_f / term.zscore_historical.n.to_f + plus_n)-(term.zscore_historical.sum.to_f/term.zscore_historical.n.to_f)**2  )
    Math.sqrt((self.sqr_total.to_f/(self.n.to_f + plus_n.to_f))-(ave(plus_n)**2))
  end

  def zscore(f, plus_n, duration)
    ((f.to_f - term.zscore_historical.ave(plus_n))/term.zscore_historical.std(plus_n))/duration
  end
end
