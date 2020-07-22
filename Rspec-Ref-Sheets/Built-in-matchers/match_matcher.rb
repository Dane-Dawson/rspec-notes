#calls #match on the object, passing if it returns truthy. Regexp and String both provide a #match method

    expect("a string").to match(/str/) # passes
    expect("a string").to match(/foo/) # fails
    expect(/foo/).to match("food")     # passes
    expect(/foo/).to match("drinks")   # fails

#This can also be used to match nested data structures

#Example Scenarios

#string usage
    RSpec.describe "a string" do
        it { is_expected.to match(/str/) }
        it { is_expected.not_to match(/foo/) }
    
        # deliberate failures
        it { is_expected.not_to match(/str/) }
        it { is_expected.to match(/foo/) }
    end

#regular expression usage
    RSpec.describe /foo/ do
        it { is_expected.to match("food") }
        it { is_expected.not_to match("drinks") }
    
        # deliberate failures
        it { is_expected.not_to match("food") }
        it { is_expected.to match("drinks") }
    end
    