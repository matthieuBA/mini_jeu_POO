class Player
    attr_accessor :name, :life_points, :dead

    #initialisation d'un nouveau joueur avec 10 points d vie
    def initialize(name)
      @name = name
      @life_points = 10
    end
  
    #affichage de l'état de santé d'un joueur
    def show_state
      return "#{@name} à #{@life_points} points de vie"
    end
  
    #métode pour recevoir des dommages
    def gets_damage(damage_received)
      @life_points -= damage_received
      if @life_points<=0
        draw_dead("YOU ARE DEAD #{@name}")
      end
    end
  
    def compute_damage
      return rand(1..6)
    end
  
    def attacks(attacked_player)
      @attacked_player = attacked_player
      @compute_damage = compute_damage
      draw_attack("le joueur #{@name} attaque le joueur #{@attacked_player.name}")
      draw_attack("#{@name} inflige à #{@attacked_player.name} #{@compute_damage} point(s) de dégats ")
      attacked_player.gets_damage(@compute_damage)
      draw_attack("remaining life of #{@attacked_player.name} = #{@attacked_player.life_points }")
      return @attacked_player.life_points 
    end
  
  end
  
  class HumanPlayer < Player
  
    attr_accessor :weapon_level
  
    def initialize(name)
      @name = name
      @life_points = 100
      @weapon_level = 1
    end
  
    def show_state
      return "#{@name} à #{@life_points} points de vie et une arme de niveau #{@weapon_level}"
      
    end
  
    def compute_damage
      return rand(1..6) * @weapon_level
    end
  
    def search_weapon
      level=rand(1..6)
      draw_weapon_green("Tu as trouvé une arme de niveau #{level}")
      if level > @weapon_level
        @weapon_level = level
        draw_weapon_green("Youhou ! elle est meilleure que ton arme actuelle : tu la prends.")
      else
        draw_weapon_red("M@*#$... elle n'est pas mieux que ton arme actuelle...")
      end
    end
  
    def search_health_pack
      health=rand(1..6)
      case health
      when 1
        draw_health_red("tu n'as rien trouvé")
      when 2..5
        draw_health_green("tu a trouvé 50 PV")
        if @life_points+50 < 1000
          @life_points+=50
        else
          @life_points=100
        end
        draw_health_green("ta vie est maintenant à : #{@life_points}")
  
      when 6
        draw_health_green("tu a trouvé 80 PV")
        if @life_points+80 < 1000
          @life_points+=80
        else
          @life_points=100
        end
        draw_health_green("ta vie est maintenant à : #{@life_points}")
      end
      
    end
  
  end


  #######################
  #COLOR MENU DEFINITION#
  #######################
  def draw_attack(string)
    box = TTY::Box.frame( width: 100,align: :center, style: {fg: :white, bg: :red, border: { fg: :white, bg: :red }}) do 
      string
    end
    puts box
  end

  def draw_weapon_green(string)
    box = TTY::Box.frame( width: 100,align: :center, style: {fg: :green, bg: :black, border: { fg: :green, bg: :black }}) do 
      string
    end
    puts box
  end

  def draw_weapon_red(string)
    box = TTY::Box.frame( width: 100,align: :center, style: {fg: :red, bg: :black, border: { fg: :red, bg: :black }}) do 
      string
    end
    puts box
  end

  def draw_health_green(string)
    box = TTY::Box.frame( width: 100,align: :center, style: {fg: :green, bg: :black, border: { fg: :green, bg: :black }}) do 
      string
    end
    puts box
  end

  def draw_health_red(string)
    box = TTY::Box.frame( width: 100,align: :center, style: {fg: :red, bg: :black, border: { fg: :red, bg: :black }}) do 
      string
    end
    puts box
  end

  def draw_dead(string)
    box = TTY::Box.frame( width: 100,align: :center, style: {fg: :red, bg: :black, border: { fg: :red, bg: :black }}) do 
      string
    end
    puts box
  end