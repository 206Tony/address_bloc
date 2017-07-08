require_relative '../models/address_book'

RSpec.describe AddressBook do
	# #1 new instance of AddressBook model and assign it to var book using let
	# lets me use book in all tests, removing duplication of having AddressBook.new in each test
	let(:book) { AddressBook.new }

	# #6 helper method created which consolidates redundencies
	def check_entry(entry, expected_name, expected_number, expected_email)
		expect(entry.name).to eq expected_name
		expect(entry.phone_number).to eq expected_number
		expect(entry.email).to eq expected_email
	end

	# #2 it explains functionality of model being tested in readable form
	#RSpec takes contents of describe and it and outputs them nicely to command line when test is executed

	describe "attributes" do
		it "responds to entries" do
			expect(book).to respond_to(:entries)
			book.import_from_csv("entries.csv")
			#Check the first entry
			entry_one = book.entries[0]
			check_entry(entry_one, "Bill", "555-555-4854", "bill@blocmail.com")
		end

		it "imports the 2nd entry" do
			book.import_from_csv("entries.csv")
			#Check 2nd entry
			entry_two = book.entries[1]
			check_entry(entry_two, "Bob", "555-555-5415", "bob@blocmail.com")
		end

		it "imports the 3rd entry" do
			book.import_from_csv("entries.csv")
			#Check 3rd entry
			entry_three = book.entries[2]
			check_entry(entry_three, "Joe", "555-555-3660", "joe@blocmail.com")
		end

		it "imports the 4th entry" do
			book.import_from_csv("entries.csv")
			#Check 4th entry
			entry_four = book.entries[3]
			check_entry(entry_four, "Sally", "555-555-4646", "sally@blocmail.com")
		end

		it "imports the 5th entry" do
			book.import_from_csv("entries.csv")
			#Check 5th entry
			entry_five = book.entries[4]
			check_entry(entry_five, "Sussie", "555-555-2036", "sussie@blocmail.com")
		end

		it "initializes entries as an array" do
			expect(book.entries).to be_an(Array)
		end

		it "initializes entries as empty" do
			expect(book.entries.size).to eq(0)
		end 
	end

	context "importing from entries" do
		it "imports the correct number of entries" do
			book.import_from_csv("entries_2.csv")

			expect(book.entries.size).to eq 3
		end
		
		it "imports the 1st entry" do
			book.import_from_csv("entries_2.csv")
			#Check the first entry
			entry_one = book.entries[0]
			check_entry(entry_one, "Bill", "555-555-4854", "bill@blocmail.com")
		end

		it "imports the 2nd entry" do
			book.import_from_csv("entries_2.csv")
			#Check 2nd entry
			entry_two = book.entries[1]
			check_entry(entry_two, "Bob", "555-555-5415", "bob@blocmail.com")
		end

		it "imports the 3rd entry" do
			book.import_from_csv("entries_2.csv")
			#Check 3rd entry
			entry_three = book.entries[2]
			check_entry(entry_three, "Joe", "555-555-3660", "joe@blocmail.com")
		end
	end

	describe "#remove_entry" do
		it "removes only one entry from the address book" do
			book.add_entry('Tony Jones', '110.012.1815', 'jones.tony@jones.com')

			name = 'Ada Lovelace'
			phone_number = '010.012.1815'
			email = 'augusta.king@lovelace.com'
			book.add_entry(name, phone_number, email)

			expect(book.entries.size).to eq(2)
			book.remove_entry(name, phone_number, email)
			expect(book.entries.size).to eq(1)
			expect(book.entries.first.name).to eq('Tony Jones')
		end
	end

	describe "#add_entry" do
		it "adds only one entry to the address book" do
			book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')

			expect(book.entries.size).to eq(1)
		end

		it "adds the correct information to entries" do
			book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
			new_entry = book.entries[0]

			expect(new_entry.name).to eq('Ada Lovelace')
			expect(new_entry.phone_number).to eq('010.012.1815')
			expect(new_entry.email).to eq('augusta.king@lovelace.com')
		end
	end

	#Test that AddressBook's .import_from_csv() method is working as expected 
	describe "#import_from_csv" do
		it "imports the correct number of entries" do
			# #3 call import_from_csv method on book object which is of type AddressBook
			#pass import_from_csv the string entries.csv as parameter
			book.import_from_csv("entries.csv")
			book_size = book.entries.size 

			#Check the size of the entries in AddressBook
			expect(book_size).to eq 5
		end
	end

	# test the binary_search method
	context ".binary_search" do
		it "searches AddressBook for a non-existent entry" do
			book.import_from_csv("entries.csv")
			entry = book.binary_search("Dan")
			expect(entry).to be_nil
		end

		it "searches AddressBook for Bill" do
			book.import_from_csv("entries.csv")
			entry = book.binary_search("Bill")
			expect(entry).to be_a Entry
			check_entry(entry, "Bill", "555-555-4854", "bill@blocmail.com")
		end

		it "searches AddressBook for Bob" do
			book.import_from_csv("entries.csv")
			entry = book.binary_search("Bob")
			expect(entry).to be_a Entry
			check_entry(entry, "Bob", "555-555-5415", "bob@blocmail.com")
		end

		it "imports the 3rd entry" do
			book.import_from_csv("entries.csv")
			entry = book.binary_search("Joe")
			expect(entry).to be_a Entry
			check_entry(entry, "Joe", "555-555-3660", "joe@blocmail.com")
		end

		it "imports the 4th entry" do
			book.import_from_csv("entries.csv")
			entry = book.binary_search("Sally")
			expect(entry).to be_a Entry
			check_entry(entry, "Sally", "555-555-4646", "sally@blocmail.com")
		end

		it "imports the 5th entry" do
			book.import_from_csv("entries.csv")
			entry = book.binary_search("Sussie")
			expect(entry).to be_a Entry
			check_entry(entry, "Sussie", "555-555-2036", "sussie@blocmail.com")
		end

		it "searches AddressBook for Billy" do
			book.import_from_csv("entries.csv")
			entry = book.binary_search("Billy")
			expect(entry).to be_nil
		end
	end
	
	context ".iterative_search" do
		it "searches the AddressBook for non-existent entry" do
			book.import_from_csv("entries.csv")
			entry = book.iterative_search("Dan")
			expect(entry).to be_nil
		end

		it "searches AddressBook for Bill" do
			book.import_from_csv("entries.csv")
			entry = book.iterative_search("Bill")
			expect(entry).to be_a Entry
			check_entry(entry, "Bill", "555-555-4854", "bill@blocmail.com")
		end

		it "searches AddressBook for Bob" do
			book.import_from_csv("entries.csv")
			entry = book.iterative_search("Bob")
			expect(entry).to be_a Entry
			check_entry(entry, "Bob", "555-555-5415", "bob@blocmail.com")
		end

		it "imports the 3rd entry" do
			book.import_from_csv("entries.csv")
			entry = book.iterative_search("Joe")
			expect(entry).to be_a Entry
			check_entry(entry, "Joe", "555-555-3660", "joe@blocmail.com")
		end

		it "imports the 4th entry" do
			book.import_from_csv("entries.csv")
			entry = book.iterative_search("Sally")
			expect(entry).to be_a Entry
			check_entry(entry, "Sally", "555-555-4646", "sally@blocmail.com")
		end

		it "imports the 5th entry" do
			book.import_from_csv("entries.csv")
			entry = book.iterative_search("Sussie")
			expect(entry).to be_a Entry
			check_entry(entry, "Sussie", "555-555-2036", "sussie@blocmail.com")
		end

		it "searches AddressBook for Billy" do
			book.import_from_csv("entries.csv")
			entry = book.iterative_search("Billy")
			expect(entry).to be_nil
		end
	end

end










