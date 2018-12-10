class Player
    @@playerCount = 0

    attr_accessor :name,:health,:power,:armor,:weapon #lazy coding example {get; set;}

    def initialize(name,health,power,armor)
        @name = name #not static
        @health = health #not static
        @power = power #not static
        @armor = armor #not static
        @weapon = getWeapon #returns from func
        @@playerCount += 1 #static
    end

    def printPlayerCount
        puts @@playerCount
    end

    def isDead
        if @health < 1
            return true
        else
            return false
        end
    end

    def getWeapon
        weapons = ["axe","sword","bow"]
        #axe beats sword
        #sword beats bow
        #bow beats axe
        return weapons[rand(3)]
    end

    def attack(enemy)
        if enemy.armor >= 1
            enemy.armor -= self.power
            if enemy.armor < 1
                brokenShieldValue = -enemy.armor
                enemy.health -= brokenShieldValue
                enemy.armor = 0
                if enemy.health < 1
                    enemy.health = 0
                end
            end
        elsif enemy.armor < 1
            enemy.health -= self.power
            if enemy.health < 1
                enemy.health = 0
            end
        end

    end
    def toString
        "#{name}, Health: #{health}, Armor: #{armor}, Power: #{power}, Weapon: #{weapon}"
    end

end

def duelToDeath(p1,p2)
    puts "--------FIGHT LOG--------"
    while !p1.isDead && !p2.isDead
        p1.attack(p2)
        p2.attack(p1)
        showInfo(p1,p2)
    end

    if !p1.isDead
        puts "-------------------------"
        puts "#{p1.name} is alive, #{p1.name} WON the duel"
    elsif !p2.isDead
        puts "-------------------------"
        puts "#{p2.name} is alive, #{p2.name} WON the duel"
    else
        puts "-------------------------"
        puts "IT IS A MASSACRE!Both #{p1.name} and #{p2.name} have died"
    end

end

def showInfo(*i)
    puts "-------------------------"
    i.each { |x| puts x.toString}
    puts "-------------------------"
end

def weaponAdvantageBonus(player,enemy)
    
    puts "EQUIPPING WEAPON BONUS"
    if player.weapon == enemy.weapon
        player.power += player.power * 1/10
        enemy.power += enemy.power * 1/10
    elsif player.weapon == "axe" && enemy.weapon == "sword"
        player.power += player.power * 1/3
        enemy.power += enemy.power * 1/10
    elsif player.weapon == "sword" && enemy.weapon == "bow"
        player.power += player.power * 1/3
        enemy.power += enemy.power * 1/10
    elsif player.weapon == "bow" && enemy.weapon == "axe"
        player.power += player.power * 1/3
        enemy.power += enemy.power * 1/10
    else
        enemy.power += enemy.power * 1/3
        player.power += player.power * 1/10
    end
end


male = Player.new("Romeo",1+rand(100),1+rand(100),rand(100))
female = Player.new("Juliette",1+rand(100),1+rand(100),rand(100))

showInfo(male,female)
weaponAdvantageBonus(male,female)
showInfo(male,female)
duelToDeath(male,female)
