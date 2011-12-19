#!/bin/bash


rm -r frequent
mkdir frequent
rm -r json
mkdir json
rm -r log
mkdir log
rm -r n
mkdir n
rm -r term
mkdir term

#cd /home/neilmarion/ROR/researches/ttanalyzer/lib/tasks && /home/neilmarion/.rvm/bin/rvm ree@ttanalyzer ruby comment_out_require.rb
cd /home/neilmarion/ROR/researches/ttanalyzer && /home/neilmarion/.rvm/bin/rvm ree@ttanalyzer rake db:drop
cd /home/neilmarion/ROR/researches/ttanalyzer && /home/neilmarion/.rvm/bin/rvm ree@ttanalyzer rake db:create
cd /home/neilmarion/ROR/researches/ttanalyzer && /home/neilmarion/.rvm/bin/rvm ree@ttanalyzer rake db:migrate

cd /home/neilmarion/ROR/researches/ttanalyzer/lib/tasks && /home/neilmarion/.rvm/bin/rvm ree@ttanalyzer ruby comment_in_require.rb
cd /home/neilmarion/ROR/researches/ttanalyzer && /home/neilmarion/.rvm/bin/rvm ree@ttanalyzer rake create_per_hour
cd /home/neilmarion/ROR/researches/ttanalyzer && /home/neilmarion/.rvm/bin/rvm ree@ttanalyzer rake create_per_five_min

