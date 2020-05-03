def clear_screen
    puts "\e[H\e[2J"
end



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