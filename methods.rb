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

# Make function for viewing inventory

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
    puts("NEW GAME\n\nYour name is Snot.\n\nYou've just gotten out of the clink and you're looking to make some quick $$$$$$$$$s\n\nYour buddy, Dan, tells you about an lucerative new hustle called...\n\n")
    puts('CATNAPPING')
    $character={
        :hp => 100,
        :money => 50,
        :lockpick => false,
        :crowbar => false,
        :coke_count => 5,
        :weapon => false,
        :ammo => 0
    }
    base_menu
end

def base_menu
    clear_screen
    input = nil
    while input != "q"
        puts("BASE\n\nWhat would you like to do?\n\nE: Explore\n\nV: Visit shop\n\nI: View inventory\n\nS: Save game\n\nL: Load game\n\nQ: Quit")
        input=gets.chomp.downcase
    
        if input == "s"
            save_game
        elsif input == "l"
            $character = load_game
        elsif input == "i"
            print($character)
            gets
        elsif input == "v"
            visit_shop
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
        puts("You have $#{$character[:money]}") # FIX ME
        input=gets.chomp.downcase
        if input == "c"
            clear_screen
            if $character[:money] > 5
                $character[:money] -= 5 
                $character[:coke_count] += 2
                puts("You've purchased 2 coke!")
            else
                puts("You don't have enough money!")
            end
            gets
            visit_shop
        elsif input == "a"
            clear_screen
            if $character[:money] > 5
                $character[:money] -= 5 
                $character[:ammo] += 10
                puts("You've purchased 10 ammo!")
            else
                puts("You don't have enough money!")
            end
            gets
            visit_shop
        elsif input == "r"
            clear_screen
            if $character[:money] > 150 and $character[:crowbar] == false
                $character[:money] -= 150 
                $character[:crowbar] = true
                puts("You've purchased a crowbar!")
            else
                puts("You already have this item or don't have enough money!")
            end
            gets
            visit_shop
        elsif input == "l"
            clear_screen
            if $character[:money] > 500 and $character[:lockpick] == false
                $character[:money] -= 500 
                $character[:lockpick] = true
                puts("You've purchased a lockpick!")
            else
                puts("You already have this item or don't have enough money!")
            end 
            gets
            visit_shop
        elsif input == "m"
            clear_screen
            if $character[:money] > 500 and $character[:weapon] == false
                $character[:money] -= 500 
                $character[:weapon] = true
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