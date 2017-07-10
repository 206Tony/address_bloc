# #1 include AddressBook using require_relative
require_relative '../models/address_book'

class MenuController
	attr_reader :address_book

	def initialize
		@address_book = AddressBook.new
	end

	def main_menu
		# #2 display the main menu options to command line
		puts "Main Menu - #{address_book.entries.count} entries"
		puts "1 - View all entries"
		puts "2 - Create an entry"
		puts "3 - Search for an entry"
		puts "4 - Import entries from a CSV"
		puts "5 - View entry n"
		puts "6 - Nuke all Entries"
		puts "7 - Exit"
		print "Enter your selection: "

		# #3 retrieve user input from command line using gets. gets reads next line fron standard input.
		selection = gets.to_i
		puts "You picked #{selection}"

		# #7 use case statement operator to determine proper respnse to user input
		case selection 
		when 1
			system "clear"
			view_all_entries
			main_menu
		when 2
			system "clear"
			create_entry
			main_menu
		when 3
			system "clear"
			search_entries
			main_menu
		when 4 
			system "clear"
			read_csv
			main_menu
		when 5 
			system "clear"
			entry_n_submenu
			main_menu
		when 6
			system "clear"
			@address_book.nuke
			puts "Some people wanna see the world burn!"
			main_menu
		when 7
			puts "Later Gator!"
			# #8 terminate program using exit(0) 0 signals exit without error
			exit(0)
			# #9 use else to catch invalid user input and prompt to retry
		else 
			system "clear"
			puts "Sorry, that is not a valid input"
			main_menu
		end
	end

	def entry_n_submenu
		print "Entry number to view: "
		selection = gets.chomp.to_i 

		if selection < @address_book.entries.count
			puts @address_book.entries[selection]
			puts "Press enter to return to the main menu"
			gets.chomp
			system "clear"
		else
			puts "#{selection} is not a valid input"
			entry_n_submenu
		end
	end

	# #10 stub the rest of the methods called in main_menu
	def view_all_entries
	# #14 iterate thru entries in AddressBook using each
		address_book.entries.each do |entry|
			system "clear"
			puts entry.to_s
		# #15 call entry_submenu to display a submenu for each entry 
			entry_submenu(entry)
		end

		system "clear"
		puts "End of entries"
	end

	def create_entry
		# #11 clear the screen before displaying create entry prompts
		system "clear"
		puts "New AddressBloc Entry"
		# #12 print prompts user for each Entry attr. Print works like puts except no newline added.
		print "Name: "
		name = gets.chomp
		print "Phone number: "
		phone = gets.chomp
		print "Email: "
		email = gets.chomp

		# #13 add new entry to address_book using add_entry to ensure new entry is added in proper order.
		address_book.add_entry(name, phone, email)

		system "clear"
		puts "New entry created" 
	end

	def search_entries
		# #9 get name to search for and store in name
		print "Search by name: "
		name = gets.chomp
		# #10 call search which returns a match or nil, won't return empty name b/c import_from_csv will fail
		match = address_book.binary_search(name)
		system "clear"
		# #11 if search has a match call search_submenu, else returns false and nil
		# search_submenu displays commands for Entry.
		if match 
			puts match.to_s
			search_submenu(match)
		else 
			puts "No match found for #{name}"
		end
	end

	def search_submenu(entry)
		# #12 print out submenu for an entry
		puts "\nd - delete entry"
		puts "e - edit this entry"
		puts "m - return to main menu"
		# #13 save input to selection
		selection = gets.chomp

		# #14 use case statement to take action based on input
		# if d call delete_entry and return to main menu
		# if e call edit_entry 
		# if m return to main menu
		# else clear screen and ask for input again by calling search_submenu
		case selection 
		when "d"
			system "clear"
			delete_entry(entry)
			main_menu
		when "e"
			edit_entry(entry)
			system "clear"
			main_menu
		when "m"
			system "clear"
			main_menu
		else
			system "clear"
			puts "#{selection} is not a valid input"
			puts entry.to_s
			search_submenu(entry)
		end
	end

	def read_csv
		# #1 prompt user to enter CSV file to import
		#file comes from STDIN and call the chomp method to remove newlines
		print "Enter CSV file to import: "
		file_name = gets.chomp

		# #2 see if file name is empty, if empty return to main menu
		if file_name.empty?
			system "clear"
			puts "No CSV file read"
			main_menu
		end 

		# #3 import file with import_from_csv. Clear screen and show # of entries
		#  
		begin
			entry_count = address_book.import_from_csv(file_name).count
			system "clear"
			puts "#{entry_count} new entries added from #{file_name}"
		rescue
			puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
			read_csv
		end
	end

	def delete_entry(entry)
		address_book.entries.delete(entry)
		puts "#{entry.name} has been deleted"
	end

	def edit_entry(entry)
		# #4 perform series of prints followed by gets.chomp ea. gets.chomp gathers user input and assigns it to appropriate name var.
		print "Updated name: "
		name = gets.chomp
		print "Updated phone number: "
		phone_number = gets.chomp
		print "Updated email: "
		email = gets.chomp
		# #5 !attribute.empty? to set attr. on entry only if a valid attr. was read from user input
		entry.name = name if !name.empty?
		entry.phone_number = phone_number if !phone_number.empty?
		entry.email = email if !email.empty?
		system "clear"
		# #6 print entry with updated attr.
		puts "Updated entry:"
		puts entry
	end

	def entry_submenu(entry)
		# #16 display submenu options 
		puts "n - next entry"
		puts "d - delete entry"
		puts "e - edit this entry"
		puts "m - return to main menu"

		# #17 chomp removes trailing whitespace from string gets returns. 
			#necessary b\c "m " or "m\n" won't match "m"
		selection = gets.chomp

		case selection
		# #18 when user asks to see next entry, we can do nothing and control returns to view_all_entries 
			when "n"
		# #19 user shown next entry 
			when "d"
		# #7 if user presses d call delet_entry. After returns to view_all_entries and next entry is displayed
				delete_entry(entry)
			when "e"
		# #8 when e display submenu with entry_submenu for entry under edit
				edit_entry(entry)
				entry_submenu(entry)
		# #20 return user to main menu
			when "m"
				system "clear"
				main_menu
			else
				system "clear"
				puts "#{selection} is not a valid input"
				entry_submenu(entry)
		end
	end
end