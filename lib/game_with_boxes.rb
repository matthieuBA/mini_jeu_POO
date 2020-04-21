class Game
attr_accessor :human_player, :enemies, :ennemies_out, :ennemies_in_sight, :player_left

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

def kill_player(player)
  @ennemies_in_sight.each_with_index do |ennemie, i|
    if @ennemies_in_sight[i]==player
      @ennemies_in_sight.delete_at(i)
    end
  end
  @player_left-=1
end

def is_still_ongoing?
  if @user.life_points >0 && @player_left >0
    return true
  else
    return false
  end
end

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


def show_players
  draw_info_white(@user.show_state)
  draw_info_red("Il reste #{@ennemies.count} joueur(s)")
end

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

def ennemies_attack
  @ennemies_in_sight.each_with_index do |ennemie, i|
    ennemie.attacks(@user)
  end
end

def end
  if @user.life_points >0 && @ennemies.count ==0
    draw_win("~"*100)
    draw_win("~"*100)
    draw_win("BRAVO tu as gagné")
    draw_win("~"*100)
    draw_win("~"*100)
  else
    draw_loose("~"*100)
    draw_loose("~"*100)
    draw_loose("LOOSER")
    draw_loose("~"*100)
    draw_loose("~"*100)
  end
end

#######################
#COLOR MENU DEFINITION#
#######################
def draw_ennemie(string)
  box = TTY::Box.frame( width: 100,align: :center,border: :ascii, style: {fg: :white, bg: :red, border: { fg: :white, bg: :red ,}}) do 
    string
  end
  puts box
end

def draw_user(string)
  box = TTY::Box.frame( width: 100,align: :center, style: {fg: :blue, bg: :white, border: { fg: :blue, bg: :white }}) do 
    string
  end
  puts box
end

def draw_menu(string)
  box = TTY::Box.frame( width: 100,align: :center, style: {fg: :white, bg: :blue, border: { fg: :white, bg: :blue }}) do 
    string
  end
  puts box
end

def draw_ennemie_in_sight(string)
  box = TTY::Box.frame( width: 100,align: :center, style: {fg: :white, bg: :blue, border: { fg: :red, bg: :blue, }}) do 
    string
  end
  puts box
end

def draw_info_white(string)
  box = TTY::Box.frame( width: 100,align: :center, style: {fg: :bright_white, bg: :green, border: { fg: :bright_white, bg: :green }}) do 
    string
  end
  puts box
end

def draw_info_red(string)
  box = TTY::Box.frame( width: 100,align: :center, style: {fg: :red, bg: :green, border: { fg: :red, bg: :green }}) do 
    string
  end
  puts box
end

def draw_chomp(string)
  box = TTY::Box.frame( width: 100,align: :center, style: {fg: :black, bg: :white, border: { fg: :black, bg: :white }}) do 
    string
  end
  puts box
end

def draw_win(string)
  box = TTY::Box.frame( width: 100,align: :center, style: {fg: :green, bg: :white, border: { fg: :green, bg: :white }}) do 
    string
  end
  puts box
end

def draw_loose(string)
  box = TTY::Box.frame( width: 100,align: :center, style: {fg: :red, bg: :white, border: { fg: :red, bg: :white }}) do 
    string
  end
  puts box
end
end