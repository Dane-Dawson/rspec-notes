#Use to specify *all* of a collection's objects pass expected matcher

expect([1, 3, 5]).to all( be_odd )
expect([1, 3, 5]).to all( be_an(Integer) )
expect([1, 3, 5]).to all( be < 10 )
expect([1, 3, 4]).to all( be_odd ) # fails

#The matcher also supports compound matchers:

expect([1, 3, 5]).to all( be_odd.and be < 10 )
expect([1, 4, 21]).to all( be_odd.or be < 10 )

#If you are looking for "any" member of a collection that passes an expectation, look at the include-matcher.

#example scenarios

#array usages
    RSpec.describe [1, 3, 5] do
        it { is_expected.to all( be_odd ) }
        it { is_expected.to all( be_an(Integer) ) }
        it { is_expected.to all( be < 10 ) }
    
        # deliberate failures
        it { is_expected.to all( be_even ) }
        it { is_expected.to all( be_a(String) ) }
        it { is_expected.to all( be > 2 ) }
    end

#Compound matcher usage
    RSpec.describe ['anything', 'everything', 'something'] do
        it { is_expected.to all( be_a(String).and include("thing") ) }
        it { is_expected.to all( be_a(String).and end_with("g") ) }
        it { is_expected.to all( start_with("s").or include("y") ) }
    
        # deliberate failures
        it { is_expected.to all( include("foo").and include("bar") ) }
        it { is_expected.to all( be_a(String).and start_with("a") ) }
        it { is_expected.to all( start_with("a").or include("z") ) }
    end