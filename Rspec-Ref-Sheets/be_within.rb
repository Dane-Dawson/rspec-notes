#Used to check if a value is within a delta of your expected value

#example, if trying to find the area of a circle given a radius of 3, the following answer shouldn't need to be matched exactly
> radius = 3
  => 3
> area_of_circle = radius * radius * Math::PI
  => 28.2743338823081
> area_of_circle == 28.2743338823081
  => false
#instead, you can set a margin of error for the test
  expect(area_of_circle).to be_within(0.1).of(28.3)

#More examples:
    RSpec.describe 27.5 do
        it { is_expected.to be_within(0.5).of(27.9) }
        it { is_expected.to be_within(0.5).of(28.0) }
        it { is_expected.to be_within(0.5).of(27.1) }
        it { is_expected.to be_within(0.5).of(27.0) }
    
        it { is_expected.not_to be_within(0.5).of(28.1) }
        it { is_expected.not_to be_within(0.5).of(26.9) }
    
        # deliberate failures
        it { is_expected.not_to be_within(0.5).of(28) }
        it { is_expected.not_to be_within(0.5).of(27) }
        it { is_expected.to be_within(0.5).of(28.1) }
        it { is_expected.to be_within(0.5).of(26.9) }
    end