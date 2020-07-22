#Used to specify that a code block alters a mutable state, using one of two forms
expect { do_something }.to change(object, :attribute)
expect { do_something }.to change { object.attribute }
#You can further qualify the change by chaining from and/or to or one of 
by
by_at_most
by_at_least

#Base setup for test case scenarios
    class Counter
        class << self
        def increment
            @count ||= 0
            @count += 1
        end
    
        def count
            @count ||= 0
        end
        end
    end

#expect change
    require "counter"

    RSpec.describe Counter, "#increment" do
        it "should increment the count" do
            expect { Counter.increment }.to change { Counter.count }.from(0).to(1)
        end

        # deliberate failure
        it "should increment the count by 2" do
            expect { Counter.increment }.to change { Counter.count }.by(2)
        end
    end

#expect no change
    require "counter"

    RSpec.describe Counter, "#increment" do

        #deliberate failures
        it "should not increment the count by 1 (using not_to)" do
            expect { Counter.increment }.not_to change { Counter.count }
        end

        it "should not increment the count by 1 (using to_not)" do
            expect { Counter.increment }.to_not change { Counter.count }
        end
    end