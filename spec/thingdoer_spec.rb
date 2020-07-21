require 'thingdoer'

RSpec.describe Thingdoer do
    describe '#hello' do
        it 'Method hello should equal Hello' do
            expect(Thingdoer.new.hello).to eq("Hello")
        end
    end

    describe '#hello_fail' do
        it 'Method hello_fail should *not* equal Hello' do
            expect(Thingdoer.new.hello_fail).not_to eq("Hello")
        end
    end

    describe '#hello' do
        it 'Method say_hello should include Hello' do
            expect(Thingdoer.new.say_hello[message]).to include("Hello")
        end
    end
end