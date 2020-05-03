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
            break
        elsif input == "l"
            clear_screen
            puts("LOAD GAME")
            inventory = load_game
            print(inventory)
            gets
            break
        end
        clear_screen
    end
end

def save_game(i)
    f = File.open("save.json","w")
    f.write(i.to_json)
end

def load_game()
    f = File.read("save.json")
    i = JSON.parse(f)
end

def new_game
    clear_screen
    puts("Your name is Snot.\n\nYou've just gotten out of the clink and you're looking to make some quick $$$$$$$$$s\n\nYour buddy, Dan, tells you about an lucerative new thing called...\n\n")
    puts('CATNAPPING')
    hp=100
    money=50
    inventory={
        :lockpick => false,
        :crowbar => false,
        :coke_count => 5,
        :weapon => nil,
        :ammo => 0
    }
    base_menu
end

def base_menu
    puts("What would you like to do?\n\n")
end