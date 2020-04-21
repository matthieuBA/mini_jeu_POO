class Game
    attr_accessor :human_player, :enemies, :ennemies_out, :ennemies_in_sight 
  
    def initialize(human_player_name)
      @name=human_player_name
      @ennemies=["bob","bobby","bobette","bobo"]
      @ennemies_out=[]
      @user = HumanPlayer.new(@name)
      @user.show_state
      puts
      @ennemies.each_with_index do |ennemie, i|
        @ennemies_out << Player.new(ennemie)
        @ennemies_out[i].show_state
        puts
      end
    end
  
    def kill_player(player)
      @ennemies_out.each_with_index do |ennemie, i|
        if @ennemies_out[i]==player
          @ennemies_out.delete_at(i)
        end
      end
  
    end
  
    def is_still_ongoing?
      if @user.life_points >0 && @ennemies_out.count >0
        return true
      else
        return false
      end
    end
  
    def show_players
      puts
      @user.show_state
      puts
      print "Il reste #{@ennemies_out.count} joueur(s)"
      puts
    end
  
    def menu
      puts
      puts "Quelle action veux-tu effectuer ?"
      puts
      puts "a - chercher une meilleure arme"
      puts "s - chercher à se soigner "
      puts
      puts "attaquer un joueur en vue :"
      @ennemies_out.each_with_index do |ennemie, i|
        puts
        print i
        print " - "
        print "#{@ennemies_out[i].show_state}"
        puts
      end
      @user.show_state
      puts
    end
  
    def menu_choice(choice)
      @choice=choice
      case choice
      when "a"
        @user.search_weapon
      when "s"
        @user.search_health_pack
      when ""
        puts "do nothing"
      else 
        puts choice
        if @user.attacks(@ennemies_out[choice.to_i])<=0
          kill_player(@ennemies_out[choice.to_i])
        end
        
      end
    end
  
    def ennemies_attack
      @ennemies_out.each_with_index do |ennemie, i|
        ennemie.attacks(@user)
      end
    end
  
    def end
      if @user.life_points >0 && @ennemies_out.count ==0
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
    end
  end
end