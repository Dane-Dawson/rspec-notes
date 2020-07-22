#used to specify that a string or array starts with the expected characters or elements
    expect("this string").to start_with("this")
    expect("this string").not_to start_with("that")
    expect([0,1,2]).to start_with(0, 1)

#Example Scenarios

#with a string
    RSpec.describe "this string" do
        it { is_expected.to start_with "this" }
        it { is_expected.not_to start_with "that" }
    
        # deliberate failures
        it { is_expected.not_to start_with "this" }
        it { is_expected.to start_with "that" }
    end

#with an array
    RSpec.describe [0, 1, 2, 3, 4] do
        it { is_expected.to start_with 0 }
        it { is_expected.to start_with(0, 1)}
        it { is_expected.not_to start_with(2) }
        it { is_expected.not_to start_with(0, 1, 2, 3, 4, 5) }
    
        # deliberate failures
        it { is_expected.not_to start_with 0 }
        it { is_expected.to start_with 3 }
    end