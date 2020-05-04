def clear_screen
    puts "\e[H\e[2J"
end

def main_menu
    input = nil
    while input != "q"
        puts("Main Menu:\n\nS: Start a new game\n\nL: Load an existing game\n\nQ: Exit Catnapper\n\n")
        puts("What is your choice?")
        input=gets.chomp.downcase
    
        if input == "s"
            clear_screen
            new_game
            gets
            # break
        elsif input == "l"
            clear_screen
            puts("LOAD GAME")
            $inventory = load_game
            print($inventory)
            gets
            # break
            elsif input =="q"
                clear_screen
                puts("THANKS FOR PLAYING")
                gets
                exit
        end
        clear_screen
    end
end

def save_game(i)
    begin
        f = File.open("save.json","w")
        f.write(i.to_json)
    rescue
        puts("Something went wrong while saving your data.\n\nPlease make sure that save.json is not open.")
    end

    base_menu

end

def load_game()
    begin
        f = File.read("save.json")
        i = JSON.parse(f)
    rescue
        puts("Something went wrong while loading your data.\n\nPlease make sure that save.json is not open.")
    end
        
    base_menu
end

def new_game
    clear_screen
    puts("Your name is Snot.\n\nYou've just gotten out of the clink and you're looking to make some quick $$$$$$$$$s\n\nYour buddy, Dan, tells you about an lucerative new hustle called...\n\n")
    puts('CATNAPPING')
    $hp=100
    $money=50
    $inventory={
        :money => 50,
        :lockpick => false,
        :crowbar => false,
        :coke_count => 5,
        :weapon => nil,
        :ammo => 0
    }
    base_menu
end

def base_menu
    
    input = nil
    while input != "q"
        puts("What would you like to do?\n\nE: Explore\n\nV: Visit shop\n\nI: View inventory\n\nS: Save game\n\nL: Load game")
        input=gets.chomp.downcase
    
        if input == "s"
            clear_screen
            save_game
            gets
            # break
        elsif input == "l"
            clear_screen
            $inventory = load_game
            gets
            # break
        elsif input == "i"
            print($inventory)
            gets
        elsif input == "v"
            visit_shop
        elsif input=="q"
            clear_screen
            puts("THANKS FOR PLAYING")
            gets
            exit
        end
        clear_screen
    end
end

def visit_shop
    clear_screen
    puts("SHOP")
    gets
end