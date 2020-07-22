#Used to specify that a string or array ends with expected characters or elements

expect("this string").to end_with "string"
expect("this string").not_to end_with "stringy"
expect([0, 1, 2]).to end_with 1, 2

#Example scenarios

#string usage
    RSpec.describe "this string" do
        it { is_expected.to end_with "string" }
        it { is_expected.not_to end_with "stringy" }
    
        # deliberate failures
        it { is_expected.not_to end_with "string" }
        it { is_expected.to end_with "stringy" }
    end

#array usage
    RSpec.describe [0, 1, 2, 3, 4] do
        it { is_expected.to end_with 4 }
        it { is_expected.to end_with 3, 4 }
        it { is_expected.not_to end_with 3 }
        it { is_expected.not_to end_with 0, 1, 2, 3, 4, 5 }
    
        # deliberate failures
        it { is_expected.not_to end_with 4 }
        it { is_expected.to end_with 3 }
    end