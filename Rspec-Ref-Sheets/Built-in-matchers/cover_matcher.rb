#Used to specify that a range covers one or more objects. Works on any object that responds to #cover?

expect(1..10).to cover(5)
expect(1..10).to cover(4, 6)
expect(1..10).not_to cover(11)

#Example Scenario
    RSpec.describe (1..10) do
        it { is_expected.to cover(4) }
        it { is_expected.to cover(6) }
        it { is_expected.to cover(8) }
        it { is_expected.to cover(4, 6) }
        it { is_expected.to cover(4, 6, 8) }
        it { is_expected.not_to cover(11) }
        it { is_expected.not_to cover(11, 12) }
    
        # deliberate failures
        it { is_expected.to cover(11) }
        it { is_expected.not_to cover(4) }
        it { is_expected.not_to cover(6) }
        it { is_expected.not_to cover(8) }
        it { is_expected.not_to cover(4, 6, 8) }
    
        # both of these should fail since it covers 5 but not 11
        it { is_expected.to cover(5, 11) }
        it { is_expected.not_to cover(5, 11) }
    end