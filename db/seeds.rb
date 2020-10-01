# frozen_string_literal: true

require 'csv'

csv_file = "#{Rails.root}/lib/seeds/pokemon.csv"
count = 0
puts "Importing pokemons from csv file #{csv_file}"

CSV.foreach(csv_file, headers: %i[id name type_1 type_2 total hp attack defense sp_atk sp_def speed generation legendary]) do |row|
  next if row[:id] == '#' # skip headers

  row.delete(:id) # IDs in CSV aren't unique so we can't rely on them to create pokemons
  row[:legendary] = row[:legendary] == 'True' # turns legendary field from string to boolean

  pokemon = Pokemon.where(name: row[:name]).first_or_initialize
  pokemon.update(row.to_h)

  if pokemon.id_previously_changed?
    puts "Creating new pokemon #{pokemon.name}"
  else
    puts "Updating pokemon #{pokemon.name}"
  end
  count += 1
rescue StandardError => e
  puts "Error while importing pokemon #{row[:name]}. Msg: #{e.message}"
end

puts "Importation done. Total #{count} pokemons imported"
