require 'bundler'
require 'pry'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

# puts 
# binding.pry
# puts
puts "#"*100
puts "NEW GAME"
puts "#"*100
player1 = Player.new("Josiane")
player2 = HumanPlayer.new("José")
puts "voici l'état de chaque joueurs"
puts "-"*100
puts player1.show_state
puts "-"*100
puts player2.show_state
puts "-"*100
puts "="*100
puts "FIGHT"
puts "="*100
while player1.life_points > 0 && player2.life_points > 0
    # puts "_"*100
    puts "Passons à la phase d'attaque :"
    player1.attacks(player2) 
    player2.life_points <= 0 ? break :
    player2.search_health_pack
    player2.attacks(player1)
    puts "_"*100
    puts 
end





