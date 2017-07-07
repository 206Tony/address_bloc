require_relative 'controllers/menu_controllers'
require_relative 'entries.csv'
# #4 create new MenuController when AddressBloc starts
menu = MenuController.new
# #5 use system "clear" to clear command line 
system "clear"
puts "Welcome to AddressBloc!"
# #6 call main_menu to display menu
menu.main_menu
entries.csv