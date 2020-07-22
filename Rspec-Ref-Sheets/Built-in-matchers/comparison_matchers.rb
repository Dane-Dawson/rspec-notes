#Comparing integer values
    RSpec.describe 18 do
        it { is_expected.to be < 20 }
        it { is_expected.to be > 15 }
        it { is_expected.to be <= 19 }
        it { is_expected.to be >= 17 }
    
        # deliberate failures
        it { is_expected.to be < 15 }
        it { is_expected.to be > 20 }
        it { is_expected.to be <= 17 }
        it { is_expected.to be >= 19 }
        it { is_expected.to be < 'a' }
    end
    
    RSpec.describe 'a' do
        it { is_expected.to be < 'b' }
    
        # deliberate failures
        it { is_expected.to be < 18 }
    end

#Can also be used for string operator matchers
    RSpec.describe "Strawberry" do
        it { is_expected.to be < "Tomato" }
        it { is_expected.to be > "Apple" }
        it { is_expected.to be <= "Turnip" }
        it { is_expected.to be >= "Banana" }
    
        # deliberate failures
        it { is_expected.to be < "Cranberry" }
        it { is_expected.to be > "Zuchini" }
        it { is_expected.to be <= "Potato" }
        it { is_expected.to be >= "Tomato" }
    end
