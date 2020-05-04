require_relative "methods.rb"
require "json"

$hp=nil
$inventory={
    :money => nil,
    :lockpick => false,
    :crowbar => false,
    :coke_count => 0,
    :weapon => nil,
    :ammo => 0
}

puts("CATNAPPER\n\n")
main_menu