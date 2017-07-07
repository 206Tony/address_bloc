# # 8 load entry.rb library relative to address_book.rb, using require_relative 
require_relative 'entry'
require "csv"

class AddressBook
	attr_reader :entries

	def initialize
		@entries = []
	end

	def remove_entry(name, phone_number, email)
		delete_entry = nil
		entries.each do |entry|
			if name == entry.name && phone_number == entry.phone_number && email == entry.email
				delete_entry = entry
			end
		end
		@entries.delete(delete_entry)
	end

	def add_entry(name, phone_number, email)
		# #9 create variable to store insertion index
		index = 0
		entries.each do |entry|
		# #10 compare name with name of current entry. 
			# If name lexicographically proceeds entry.name we've found the index to insert at.
			# Otherwise increment index and continue comparing with other entries
			if name < entry.name
				break
			end
			index += 1
		end
		# #11 insert a new entry into entries using calculated `index. 
		entries.insert(index,Entry.new(name, phone_number, email))
	end
	# #7 define import_from_csv method starts by reading File.read
	# use CSV to parse the file.  result is an object of type CSV::Table
	def import_from_csv(file_name)
		csv_text = File.read(file_name)
		csv = CSV.parse(csv_text, headers: true, skip_blanks: true)
	# #8 iterate over CSV::Table objects rows. next create hash
	# convert each row_hash to an Entry by using the add_entry method which also adds Entry to AddressBooks entries
		csv.each do |row|
			row_hash = row.to_hash
			add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
		end
	end

	# Search AddressBook for a specific entry by name
	def binary_search(name)
		# #1 save leftmost item in the array in var named lower and upper for the rightmost
		lower = 0
		upper = entries.length - 1 #rightmost item

		# #2 loop while lower index is less than r equal to upper index
		while lower <= upper
		# #3 find mid index by summing up and low and dividing by 2
		#Ruby truncates any dec # if up is 5 and low 0 mid is 2
		#then retrieve mid entry index and store in mid_name
			mid = (lower + upper) / 2
			mid_name = entries[mid].name
		
		# #4 compare name being searched with name to mid_name use == makes search case sensitive
			if name == mid_name 
				return entries[mid]
			elsif name < mid_name
				upper = mid -1
			elsif name > mid_name 
				lower = mid + 1 
			end
		end

		# #5 if divide and conquer returns no match return nil
		return nil
	end
end