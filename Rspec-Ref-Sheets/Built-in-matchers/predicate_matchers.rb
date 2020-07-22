#Ruby's commonly provided predicate method refresher

    7.zero?                  # => false
    0.zero?                  # => true
    [1].empty?               # => false
    [].empty?                # => true
    { :a => 5 }.has_key?(:b) # => false
    { :b => 5 }.has_key?(:b) # => true

#Rspec's corresponding syntax
    expect(7).not_to be_zero       # calls 7.zero?
    expect([]).to be_empty         # calls [].empty?
    expect(x).to be_multiple_of(3) # calls x.multiple_of?(3)
    expect(hash).to have_key(:foo)       # calls hash.has_key?(:foo)
    expect(array).not_to have_odd_values # calls array.has_odd_values?

#Quick reference guide for common cases, deliberate failure examples included in most

#should be_zero (based on Integer#zero?)
    RSpec.describe 0 do
        it { is_expected.to be_zero }
    end
    
    RSpec.describe 7 do
        it { is_expected.to be_zero } # deliberate failure
    end

#should_not be_empty (based on Array#empty?)
    RSpec.describe [1, 2, 3] do
        it { is_expected.not_to be_empty }
    end
    
    RSpec.describe [] do
        it { is_expected.not_to be_empty } # deliberate failure
    end

#should have_key (based on Hash#has_key?)
    RSpec.describe Hash do
        subject { { :foo => 7 } }
        it { is_expected.to have_key(:foo) }
        it { is_expected.to have_key(:bar) } # deliberate failure
    end

#should_not have_all_string_keys (based on custom #has_all_string_keys? method)
    class Hash
        def has_all_string_keys?
            keys.all? { |k| String === k }
        end
    end
    
    RSpec.describe Hash do
        context 'with symbol keys' do
            subject { { :foo => 7, :bar => 5 } }
            it { is_expected.not_to have_all_string_keys }
        end
    
        context 'with string keys' do
            subject { { 'foo' => 7, 'bar' => 5 } }
            it { is_expected.not_to have_all_string_keys } # deliberate failure
        end
    end

#matcher arguments are passed on to the predicate method
    class Integer
        def multiple_of?(x)
            (self % x).zero?
        end
    end
    
    RSpec.describe 12 do
        it { is_expected.to be_multiple_of(3) }
        it { is_expected.not_to be_multiple_of(7) }
    
        # deliberate failures
        it { is_expected.not_to be_multiple_of(4) }
        it { is_expected.to be_multiple_of(5) }
    end

#calling private method with be_predicate causes error
    class WithPrivateMethods
        def secret?
            true
        end
        private :secret?
    end
    
    RSpec.describe 'private methods' do
        subject { WithPrivateMethods.new }
    
        # deliberate failure
        it { is_expected.to be_secret }
    end

#calling private method with have_predicate causes error
    class WithPrivateMethods
        def has_secret?
            true
        end
        private :has_secret?
    end
    
    RSpec.describe 'private methods' do
        subject { WithPrivateMethods.new }
    
        # deliberate failure
        it { is_expected.to have_secret }
    end