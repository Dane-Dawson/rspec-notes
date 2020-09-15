require 'thingdoer'

RSpec.describe Thingdoer do
    describe '#hello' do
        it 'Method hello should equal Hello' do
            expect(Thingdoer.new.hello).to eq("Hello")
        end
    end

    
    describe '#return_hello' do
        it "Method return_hello returns value of 'Hello'" do
            expect(Thingdoer.new.return_hello).to eq("Hello")
        end
    end

    describe '#return_goodbye' do
        it 'Method return_goodbye should equal GoodBye' do
            expect(Thingdoer.new.return_goodbye).not_to eq("Hello")
            expect(Thingdoer.new.return_goodbye).not_to eq("and")
            expect(Thingdoer.new.return_goodbye).to eq("Goodbye")

        end
    end

    describe '#hello_fail' do
        it 'Method hello_fail should *not* equal Hello' do
            expect(Thingdoer.new.hello_fail).not_to eq("Hello")
        end
    end

    describe '#hello' do
        it 'Method say_hello should include Hello' do
            expect(Thingdoer.new.say_hello).to include("Hello")
        end
    end

end