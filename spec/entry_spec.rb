require_relative '../models/entry'
# #1 First line of test file. File is a spec file and tests Entry
RSpec.describe Entry do
  # #2 describe gives test structure.  Communicates specs test Entry Attr. file
  describe "attributes" do
  	let(:entry){ Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com') }
    # #3 it seperates individual tests.  Each it responds to unique test.
    it "responds to name" do 
    	entry = Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
    	# #4 Each RSpec test ends with one or more expect method, which declares expectations of test.
    	expect(entry).to respond_to(:name)
    end

    it "reports its name" do
    	expect(entry.name).to eq('Ada Lovelace')
    end

    it "responds to phone number" do 
    	expect(entry).to respond_to(:phone_number)
    end

    it "reports its phone_number" do
    	expect(entry.phone_number).to eq('010.012.1815')
    end

    it "responds to email" do
    	expect(entry).to respond_to(:email)
    end

    it "reports its email" do
    	expect(entry.email).to eq('augusta.king@lovelace.com')
    end
  end
  # #5 New describe block to separate the to_s test from the initialized test
  		# # in front of to_s indicates it's an instance method
  describe "#to_s" do 
  	it "prints an entry as a string" do
  		entry = Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
  		expected_string = "Name: Ada Lovelace\nPhone Number: 010.012.1815\nEmail: augusta.king@lovelace.com"
  # #6 eq used to check to_s returns a string equal to expected_string
  		expect(entry.to_s).to eq(expected_string)
  	end
  end
end