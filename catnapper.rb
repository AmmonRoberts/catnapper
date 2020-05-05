require "json"

def clear_screen
    puts "\e[H\e[2J"
end

def exit_game
    clear_screen
    puts("THANKS FOR PLAYING")
    gets
    clear_screen
    exit
end

def print_inventory
    clear_screen
    puts("INVENTORY\n\n")
    puts("HP: #{$character["hp"]}\n")
    puts("Money: $#{$character["money"]}\n")
    puts("Coke: #{$character["coke_count"]}\n")
    if $character["crowbar"] == true
        puts("Crowbar")
    end
    if $character["lockpick"] == true
        puts("Lockpick")
    end
    if $character["weapon"] == true
        puts(".44 magnum")
    end
    puts("Ammo: #{$character["ammo"]}\n")

end

def drink_coke
    clear_screen
    if $character["coke_count"] > 0
        if $character["hp"] < 100
            $character["coke_count"] -= 1
            $character["hp"] += 30
            if $character["hp"] > 100
                $character["hp"] = 100
            end
            puts("You feel refreshed!\n\nYour HP is now: #{$character["hp"]}")
        else
            puts("You're at full health!")
        end
    else
    puts("You don't have any coke to drink!")
    end
    gets
end

def main_menu
    clear_screen
    
    input = nil
    while input != "q"
        puts("MAIN MENU\n\nS: Start a new game\n\nL: Load an existing game\n\nQ: Exit Catnapper\n\n")
        puts("What is your choice?")
        input=gets.chomp.downcase
    
        if input == "s"
            new_game
        elsif input == "l"
            puts("LOAD GAME")
            $character = load_game
        elsif input =="q"
            exit_game
        end
        clear_screen
    end
end

def save_game()
    clear_screen
    begin
        f = File.open("save.json","w")
        f.write($character.to_json)
        puts("Game successfully saved!")
        gets
    rescue
        puts("Something went wrong while saving your data.\n\nPlease make sure that save.json is not open.")
        gets
    end
    
    base_menu
end

def load_game()
    clear_screen
    begin
        f = File.read("save.json")
        $character = JSON.parse(f)
        puts("Game successfully loaded!")
        gets
    rescue
        puts("Something went wrong while loading your data.\n\nPlease make sure that save.json is not open.")
    end
        
    base_menu
end

def new_game
    clear_screen
    puts("NEW GAME\n\nYour name is Andy.\n\nYou've just gotten out of the clink and you're looking to make some quick $$$$$$$$$s\n\nYour buddy, Dan, tells you about a lucerative new hustle called...\n\n")
    puts('CATNAPPING')
    $character={
        "hp" => 100,
        "money" => 50,
        "lockpick" => false,
        "crowbar" => false,
        "coke_count" => 5,
        "weapon" => false,
        "ammo" => 0
    }
    base_menu
end

def base_menu
    clear_screen
    input = nil
    while input != "q"
        puts("BASE\n\nWhat would you like to do?\n\nE: Explore\n\nD: Drink coke\n\nI: View inventory\n\nV: Visit shop\n\nS: Save game\n\nL: Load game\n\nQ: Quit")
        input=gets.chomp.downcase
    
        if input == "s"
            save_game
        elsif input == "l"
            $character = load_game
        elsif input == "i"
            print_inventory
            gets
        elsif input == "v"
            visit_shop
        elsif input == "d"
            drink_coke
        elsif input =="q"
            exit_game
        end
        clear_screen
    end
end

def visit_shop
    input = nil
    while input != "b"
        clear_screen
        puts("SHOP")
        puts("What would you like to purchase?\n\nC: Coke - $5 for 2\n\nA: ammo - $5 for 10\n\nR: Crowbar - $150\n\nL: Lockpick - $500\n\nM: .44 magnum - $500\n\nB: Back")
        puts("You have $#{$character["money"]}")
        input=gets.chomp.downcase
        if input == "c"
            clear_screen
            if $character["money"] > 5
                $character["money"] -= 5 
                $character["coke_count"] += 2
                puts("You've purchased 2 coke!")
            else
                puts("You don't have enough money!")
            end
            gets
            visit_shop
        elsif input == "a"
            clear_screen
            if $character["money"] > 5
                $character["money"] -= 5 
                $character["ammo"] += 10
                puts("You've purchased 10 ammo!")
            else
                puts("You don't have enough money!")
            end
            gets
            visit_shop
        elsif input == "r"
            clear_screen
            if $character["money"] > 150 and $character["crowbar"] == false
                $character["money"] -= 150 
                $character["crowbar"] = true
                puts("You've purchased a crowbar!")
            else
                puts("You already have this item or don't have enough money!")
            end
            gets
            visit_shop
        elsif input == "l"
            clear_screen
            if $character["money"] > 500 and $character["lockpick"] == false
                $character["money"] -= 500 
                $character["lockpick"] = true
                puts("You've purchased a lockpick!")
            else
                puts("You already have this item or don't have enough money!")
            end 
            gets
            visit_shop
        elsif input == "m"
            clear_screen
            if $character["money"] > 500 and $character["weapon"] == false
                $character["money"] -= 500 
                $character["weapon"] = true
                puts("You've purchased a .44 magnum!")
            else
                puts("You already have this item or don't have enough money!")
            end
            gets
            visit_shop
        elsif input=="b"
            base_menu
        end
    end
end

def explore

end

puts("CATNAPPER\n\n")
main_menu