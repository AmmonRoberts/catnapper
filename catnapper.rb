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

puts("CATNAPPER\n\n")
main_menu

puts("THANKS FOR PLAYING")
gets