require 'bundler'
require 'tty-box'
Bundler.require

require_relative 'lib/game_with_boxes'
require_relative 'lib/player_with_boxes'

my_game = Game.new("Wolverine")

while my_game.is_still_ongoing?
my_game.new_players_in_sight
my_game.menu
my_game.menu_choice(gets.chomp)
my_game.ennemies_attack
end

my_game.end
