class Game
  attr_accessor :human_player, :enemies, :ennemies_out, :ennemies_in_sight, :player_left

  #######################
  #    INIT NEW GAME    #
  #######################
  def initialize(human_player_name)
    system("clear")
    @ennemies=[]
    @ennemies_in_sight=[]
    @name=human_player_name
    @player_left=20
    @player_left.times do |i|
      @ennemies << "player"+(i.to_s)
    end
    @ennemies_out=[]
    @user = HumanPlayer.new(@name)
    draw_info_white(@user.show_state)
  end

  #######################
  #  Gestion des morts  #
  #######################
  def kill_player(player)
    @ennemies_in_sight.each_with_index do |ennemie, i|
      if @ennemies_in_sight[i]==player
        @ennemies_in_sight.delete_at(i)
      end
    end
    @player_left-=1
  end


  #######################
  #   PARTIE EN COURS   #
  #######################
  def is_still_ongoing?
    if @user.life_points >0 && @player_left >0
      return true
    else
      return false
    end
  end

  #######################
  # gestion player prox #
  #######################
  def new_players_in_sight
    dice=rand(1..6)
    if @ennemies_in_sight.count == @player_left
      draw_ennemie("Tous les joueurs sont déjà en vue")
    elsif dice == 1
      draw_ennemie("Add zero ennemie")
    elsif dice >1 && dice <=4
      draw_ennemie("Add one ennemie")
      1.times do
        @ennemies_in_sight << Player.new(@ennemies[0])
        @ennemies.shift
      end
    elsif dice >=5
      draw_ennemie("Add two ennemies")
      2.times do
        @ennemies_in_sight << Player.new(@ennemies[0])
        @ennemies.shift
      end
    end
  end

  #######################
  #  AFFICHAGE  player  #
  #######################
  def show_players
    draw_info_white(@user.show_state) 
    draw_info_red("Il reste #{@ennemies.count} joueur(s)")
  end


  #######################
  #   MENU and SELECT   #
  #######################
  def menu
    draw_menu("Quelle action veux-tu effectuer ?")
    draw_menu("a - chercher une meilleure arme")
    draw_menu("s - chercher à se soigner ")
    draw_menu("attaquer un joueur en vue :")
    
    @ennemies_in_sight.each_with_index do |ennemie, i|
      str=""
      str += i.to_s 
      str += " - "
      str += "#{@ennemies_in_sight[i].show_state}"
      draw_ennemie_in_sight(str)
    end

    draw_info_white(@user.show_state)
    
    draw_info_red("les ennemies peuvent vous infliger #{@ennemies_in_sight.count*6} points de dégats au maximum")
  end

  def menu_choice(choice)
    @choice=choice
    system("clear")
    draw_chomp(choice)
    case @choice
    when "a"
      @user.search_weapon
    when "s"
      @user.search_health_pack
    when ""
      puts "nothing"
    else 
      if @user.attacks(@ennemies_in_sight[choice.to_i])<=0
        kill_player(@ennemies_in_sight[choice.to_i])
      end
      
    end
  end

  #######################
  #       ATTAQUES      #
  #######################
  def ennemies_attack
    @ennemies_in_sight.each_with_index do |ennemie, i|
      ennemie.attacks(@user)
    end
  end
  #######################
  #    FIN DE PARTIE    #
  #######################
  def end
    if @user.life_points >0 && @ennemies.count ==0
      puts ("~"*100).colorize(:green).on_white
      puts ("~"*100).colorize(:green).on_white
      puts ("BRAVO tu as gagné").colorize(:green).on_white
      puts ("~"*100).colorize(:green).on_white
      puts ("~"*100).colorize(:green).on_white
    else
      puts ("~"*100).colorize(:red).on_white
      puts ("~"*100).colorize(:red).on_white
      puts ("LOOSER").colorize(:red).on_white
      puts ("~"*100).colorize(:red).on_white
      puts ("~"*100).colorize(:red).on_white
    end
  end


  #######################
  #COLOR MENU DEFINITION#
  #######################
  def draw_ennemie(string)
    puts string.colorize(:red)
  end

  def draw_user(string)
    puts string.colorize(:blue)
  end

  def draw_menu(string)
    puts string.colorize(:white).on_green
  end

  def draw_ennemie_in_sight(string)
    puts string.blue.on_red
  end

  def draw_info_white(string)
    puts string.colorize(:white).on_blue
  end

  def draw_info_red(string)
    puts string.colorize(:red)
  end

  def draw_chomp(string)
    puts string.colorize(:white)
  end

end
