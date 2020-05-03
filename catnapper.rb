require_relative "methods.rb"
require "json"

hp=nil
money=nil
inventory={
    :lockpick => false,
    :crowbar => false,
    :coke_count => 0,
    :weapon => nil,
    :ammo => 0
}
save_game(inventory)
puts(inventory)

puts("CATNAPPER\n\n")
input = nil
while input != "q"
    puts("Main Menu:\n\nS: Start a new game\n\nL: Load an existing game\n\nQ: Exit Catnapper\n\n")
    puts("What is your choice?")
    input=gets.chomp.downcase

    if input == "s"
        clear_screen
        puts("NEW GAME")
        gets
        
    elsif input == "l"
        clear_screen
        puts("LOAD GAME")
        gets
        
    end
    clear_screen
end
puts("THANKS FOR PLAYING")
gets