filenames = ["create_per_five_min.rake", "create_per_hour.rake", "lossy_count_tweets.rake", "parse_trends.rake", "update_current_zscores.rake", "create_reports_per_min_per_hour.rake", "empty_zscore_sum_per_five_min.rake", "create_per_hour_report.rake"]

filenames.each do |f|
  text_file = File.open(f, 'r')

  lines = Array.new
  while line = text_file.gets
    lines << line
  end

  text_file.close

  text_file = File.open(f, 'w')
  lines.each do |l|
    if (l == "require 'config\/environment'\n")
      text_file.puts '#' + l
    else
      text_file.puts l
    end
  end

  text_file.close
end
