#The satisfy matcher is extremely flexible and passes if the block you provide returns true
    expect(10).to satisfy { |v| v % 5 == 0 }
    expect(7).not_to satisfy { |v| v % 5 == 0 }
#The default failure message is not very descriptive, and can be clarified thusly
    expect(10).to satisfy("be a multiple of 5") do |v|
        v % 5 == 0
    end

#basic usage (skip when ripper unsupported)
    RSpec.describe 10 do
        it { is_expected.to satisfy { |v| v > 5 } }
        it { is_expected.not_to satisfy { |v| v > 15 } }
    
        # deliberate failures
        it { is_expected.not_to satisfy { |v| v > 5 } }
        it { is_expected.to satisfy { |v| v > 15 } }
        it { is_expected.to_not satisfy("be greater than 5") { |v| v > 5 } }
        it { is_expected.to satisfy("be greater than 15") { |v| v > 15 } }
    end