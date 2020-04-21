require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "#"*100
puts "BIENVENUE DANS ILS VEULENT TOUS MA POO ;)"
puts "Le but du jeu et d'être le dernier survivant (to be the last one)"
puts "#"*100

puts "Quel est ton doux prénom"
print ">"
user = HumanPlayer.new(gets.chomp)


tab_opponents=["josé","josiane","Billy", "a", "b", "c"]
tab_out=[]
tab_alive=[]
alive_number=0

tab_opponents.each_with_index do |opponent, i|
  name=(opponent+((i).to_s))
  tab_out << name = Player.new(opponent)
  tab_alive << "true"
end

def alive(tab_opponents,tab_alive,tab_out)
  tab_opponents.each_with_index do |opponent, i|
    if tab_out[i].life_points <=0
      tab_alive[i] = "false"
    end
  end
end



#while user.life_points >0 && (tab_out[0].life_points >0 || tab_out[1].life_points >0)
while user.life_points >0 && tab_alive.include?("true") 

  alive(tab_opponents,tab_alive,tab_out)

  user.show_state
  if tab_alive.include?("true")
    puts
    puts "Quelle action veux-tu effectuer ?"
    puts
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner "
    puts
    puts "attaquer un joueur en vue :"
  else 
    puts
    break
  end


  #NEWWWWWWWWWWWWWWWWWWWWWWWWWWWW
  tab_out.each_with_index do |element, i|
    if tab_out[i].life_points >0
      print i
      print " - "
      print "#{tab_out[i].show_state}"
      puts
    end
  end
  #END NEWWWWWWWWWWWWWWWWWWWWWWWWWWWWW


  puts
  puts
  print ">"
  choice=gets.chomp


  case choice
  when "a"
    user.search_weapon
  when "s"
    user.search_health_pack
  when ""
    puts "do nothing"
  else 
    puts choice
    user.attacks(tab_out[choice.to_i]) 
  end

  alive(tab_opponents,tab_alive,tab_out)
  if tab_alive.include?("true")
    puts "Les autres joueurs t'attaquent !"
    tab_out.each_with_index do |element, i|
      if tab_out[i].life_points >0
        tab_out[i].attacks(user)
      end
    end
  else
    puts
    break  
  end

  # puts "prochain tour Y/N"
  # turn =gets.chomp

end

if user.life_points >0
  puts "~"*100
  puts "~"*100
  puts "BRAVO tu as gagné"
  puts "~"*100
  puts "~"*100
else
  puts "~"*100
  puts "~"*100
  puts "LOOSER"
  puts "~"*100
  puts "~"*100
end