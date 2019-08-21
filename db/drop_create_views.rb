# Drop and create DB views. Run after rebuilding DB
puts "Creating DB Views"

puts " - VwScores"
require './db/migrate/20190320011634_create_scores_view'
csv = CreateScoresView.new
csv.down
csv.up
