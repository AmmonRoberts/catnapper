require "json"

def clear_screen
    puts "\e[H\e[2J"
end

def exit_game
    clear_screen
    puts "THANKS FOR PLAYING"
    gets
    clear_screen
    exit
end

def print_inventory
    clear_screen
    puts "INVENTORY\n\n"
    puts "HP: #{$character["hp"]}\n"
    puts "Money: $#{$character["money"]}\n"
    puts "Coke: #{$character["coke_count"]}\n"
    if $character["crowbar"] == true
        puts "Crowbar"
    end
    if $character["lockpick"] == true
        puts "Lockpick"
    end
    if $character["weapon"] == true
        puts ".44 magnum"
    end
    puts "Ammo: #{$character["ammo"]}\n"
    puts "Cats: #{$character["cats"]}"
    gets
    base_menu
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
            puts "You feel refreshed!\n\nYour HP is now: #{$character["hp"]}"
        else
            puts "You're already at full health!"
        end
    else
    puts "You don't have any coke to drink!"
    end
    gets
end

def main_menu
    clear_screen
    # Add an option for "how to play"
    input = nil
    while 1
        puts "MAIN MENU\n\nS: Start a new game\n\nL: Load an existing game\n\nQ: Exit Catnapper\n\n"
        puts "What is your choice?"
        input=gets.chomp.downcase
    
        if input == "s"
            new_game
        elsif input == "l"
            puts "LOAD GAME"
            $character = load_game
        elsif input =="q"
            exit_game
        end
        clear_screen
    end
end

def save_game 
    clear_screen
    begin
        f = File.open "save.json","w"
        f.write $character.to_json
        puts "Game successfully saved!"
        gets
    rescue
        puts "Something went wrong while saving your data.\n\nPlease make sure that save.json is not open."
        gets
    end
    
    base_menu
end

def load_game 
    clear_screen
    if File.exist?("save.json")
        begin
            f = File.read "save.json"
            $character = JSON.parse f
            puts "Game successfully loaded!"
            gets
        rescue
            puts "Something went wrong while loading your data.\n\nPlease make sure that save.json is not open."
        end
    else
        puts "There was trouble finding your save file"
        gets
        main_menu
    end
    base_menu
end

def new_game
    clear_screen
    puts "NEW GAME\n\nYour name is Andy.\n\nYou've just gotten out of the clink and you're looking to make some quick $$$$$$$$$s\n\nYour buddy, Dan, tells you about a lucerative new hustle called...\n\n"
    puts 'CATNAPPING'
    gets
    $character={
        "hp" => 100,
        "money" => 100,
        "lockpick" => false,
        "crowbar" => false,
        "coke_count" => 5,
        "weapon" => false,
        "ammo" => 0,
        "cats" => 0
    }
    base_menu
end

def base_menu
    clear_screen

    input = nil
    while 1
        puts "BASE\n\nWhat would you like to do?\n\nE: Explore\n\nD: Drink Coke\n\nI: View inventory\n\nV: Visit shop\n\nS: Save game\n\nL: Load game\n\nQ: Quit"
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
        elsif input == "e"
            explore
        elsif input =="q"
            exit_game
        end
        clear_screen
    end
end

def visit_shop
    input = nil
    while 1
        clear_screen
        puts "SHOP"
        puts "What would you like to purchase?\n\nC: Coke - $5 for 2\n\nA: ammo - $20 for 10\n\nR: Crowbar - $150\n\nL: Lockpick - $500\n\nM: .44 magnum - $350\n\nB: Back"
        puts "You have $#{$character["money"]}"
        input=gets.chomp.downcase
        if input == "c"
            # Purchase Coke
            clear_screen
            if $character["money"] > 5
                $character["money"] -= 5 
                $character["coke_count"] += 2
                puts "You've purchased 2 coke!"
            else
                puts "You don't have enough money!"
            end
            gets
            visit_shop
        elsif input == "a"
            # Purchase ammo
            clear_screen
            if $character["money"] > 20
                $character["money"] -= 20 
                $character["ammo"] += 10
                puts "You've purchased 10 ammo!"
            else
                puts "You don't have enough money!"
            end
            gets
            visit_shop
        elsif input == "r"
            # Purchase crowbar
            clear_screen
            if $character["money"] > 150 and $character["crowbar"] == false
                $character["money"] -= 150 
                $character["crowbar"] = true
                puts "You've purchased a crowbar!"
            else
                puts "You already have this item or don't have enough money!"
            end
            gets
            visit_shop
        elsif input == "l"
            # Purchase lockpick
            clear_screen
            if $character["money"] > 500 and $character["lockpick"] == false
                $character["money"] -= 500 
                $character["lockpick"] = true
                puts "You've purchased a lockpick!"
            else
                puts "You already have this item or don't have enough money!"
            end 
            gets
            visit_shop
        elsif input == "m"
            # Purchase weapon
            clear_screen
            if $character["money"] > 350 and $character["weapon"] == false
                $character["money"] -= 350 
                $character["weapon"] = true
                puts "You've purchased a .44 magnum!"
            else
                puts "You already have this item or don't have enough money!"
            end
            gets
            visit_shop
        elsif input=="b"
            base_menu
        end
    end
end

def explore
    clear_screen
    input = nil
    while 1
        puts "While out exploring, you encounter a home to break in to.\n\nWhat would you like to do?\n\nT: Try the door\n\nB: Back"
        input=gets.chomp.downcase
    
        if input == "t"
            clear_screen
            r = rand(0..1)
            if r == 0
                puts "The door is unlocked! Sweet!"
                gets
                if rand(0..2) == 0
                    puts "No dogs at this house!"
                    gets
                    get_spoils
                else
                    fight
                end
            elsif r == 1
                puts "The door is locked."
                gets

                input = nil
                while 1
                    puts "What would you like to do?\n\nC: Use your crowbar\n\nL: Use your lockpick\n\nB: Back"
                    input=gets.chomp.downcase

                    if input == "c"
                        # Use crowbar - might wake someone up
                        clear_screen
                        if $character["crowbar"] == true
                            r = rand(0..2)
                            if r == 0
                                puts "You woke up the homeowner! Time to get outta here!"
                                gets
                                base_menu
                            elsif r == 1
                                puts " What luck! Somehow you didn't wake anybody up and there don't seem to be any dogs!"
                                gets
                                get_spoils
                            elsif r == 2
                                fight
                            end
                        else
                            puts "You don't have a crowbar, silly goose!"
                            gets
                        end
                    elsif input == "l"
                        # Use lockpick - better chance of a quiet entry
                        clear_screen
                        if $character["lockpick"] == true
                            puts "You made it in nice and quietly!"
                                gets
                            r = rand(0..1)
                            if r == 0
                                get_spoils
                            elsif r == 1
                                fight
                            end
                        else
                            puts "You don't have a lockpick, silly goose!"
                            gets
                        end
                    elsif input == "b"
                        base_menu   
                    end
                end                     
            end
        elsif input == "b"
            base_menu
        end
        clear_screen
    end
end

def fight
    clear_screen
    puts "There's a dog at this house!"
    gets
    clear_screen
    dog_HP = 100
    input = nil
    while 1
        puts "FIGHT\n\nWhat would you like to do?\n\nF: Fight!\n\nD: Drink Coke!\n\nR: Run!\n\n"
        puts "Your HP: #{$character["hp"]}\n\nAmmo: #{$character["ammo"]}\n\nDog's HP: #{dog_HP}"
        input=gets.chomp.downcase
    
        if input == "f"
            # If you have a weapon and ammo, you can fight
            if $character["weapon"] == true and $character["ammo"] > 0
                clear_screen

                # Dog attacks first
                r = rand(0..2)
                if r == 0
                    puts "The dog tried to bite you, but it missed!"
                    gets
                    clear_screen
                else
                    damage = rand(5..15)
                    $character["hp"] -= damage
                    puts "The dog bit you and you took #{damage} damage!"
                    gets
                    check_health
                end

                # You attack next
                $character["ammo"] -= 1
                r = rand(0..2)
                if r == 0
                    puts "Your shot missed!"
                    gets
                    clear_screen
                else
                    damage = rand(5..15)
                    dog_HP -= damage
                    puts "You hit the dog and it took #{damage} damage!"
                    gets
                end 

                # If you beat the dog, move on and get stuff!
                if dog_HP  <= 0
                    puts "You've defeated the dog!\n\nNow go get your loot!"
                    gets
                    get_spoils
                    base_menu
                end
            else    
                clear_screen
                if $character["weapon"] == false
                    puts "You don't have a weapon to fight with!"
                    gets
                end
                if $character["ammo"] < 1
                    puts "You don't have any ammo!"
                    gets
                end
                
            end
        elsif input == "d"
            # Drink some coke - this counts as an action though, so you might take some damage!
            drink_coke
            r = rand(0..2)
                if r == 0
                    puts "The dog tried to bite you, but it missed!"
                    gets
                else
                    damage = rand(5..15)
                    $character["hp"] -= damage
                    puts "The dog bit you and you took #{damage} damage!"
                    gets
                    check_health
                end
        elsif input =="r"
            # Run from the battle - the dog might still get a hit in!
            clear_screen
            damage = rand(5..15)
            r = rand(0..2)
            if r == 0
                puts "The dog tried to bite you, but it missed!"
                gets
            else
                puts "As you were fleeing, the dog bit you and you took #{damage} damage!"
                gets
                $character["hp"] -= damage
                check_health
            end
            base_menu
        end
        clear_screen
    end
end

def get_spoils
    # This gives you stuff after you successfully break in
    clear_screen
    m = rand(0..150)
    c = rand(0..5)
    $character["money"] += m
    $character["cats"] += c
    puts "You found $#{m}\nand\n#{c} cats!"
    gets
    check_win
    base_menu
end

def check_health
    # Makes sure you aren't doing stuff after you die
    clear_screen
    if $character["hp"] <= 0
        puts "You have died..."
        gets
        main_menu
    end
end

def check_win
    # Makes sure you win if you earned it, of course!
    clear_screen
    if $character["cats"] >= 100
        puts "YOU'VE WON THE GAME!"
        gets
        main_menu
    end
end

puts "CATNAPPER\n\n"
main_menu