#Allows testing between arrays disregarding differences in order

expect([1, 2, 3]).to    contain_exactly(2, 3, 1) # pass
expect([:a, :c, :b]).to contain_exactly(:a, :c ) # fail

#Also can be written as

expect([1, 2, 3]).to    match_array [2, 3, 1] # pass
expect([:a, :c, :b]).to match_array [:a, :c]  # fail

#Example scenarios

#Array expected to contain every value
    RSpec.describe [1, 2, 3] do
        it { is_expected.to contain_exactly(1, 2, 3) }
        it { is_expected.to contain_exactly(1, 3, 2) }
        it { is_expected.to contain_exactly(2, 1, 3) }
        it { is_expected.to contain_exactly(2, 3, 1) }
        it { is_expected.to contain_exactly(3, 1, 2) }
        it { is_expected.to contain_exactly(3, 2, 1) }
    
        # deliberate failures
        it { is_expected.to contain_exactly(1, 2, 1) }
    end

#Array is not expected to contain every value
    RSpec.describe [1, 2, 3] do
        it { is_expected.to_not contain_exactly(1, 2, 3, 4) }
        it { is_expected.to_not contain_exactly(1, 2) }
    
        # deliberate failures
        it { is_expected.to_not contain_exactly(1, 3, 2) }
    end