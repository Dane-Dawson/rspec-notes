#Used to specify details of an objects interface. In it's most basic form:
    expect(obj).to respond_to(:foo) # pass if obj.respond_to?(:foo)
#passing multiple arguments to the matcher is possible
    expect(obj).to respond_to(:foo, :bar) # passes if obj.respond_to?(:foo) && obj.respond_to?(:bar)
#You can also specify number of arguments expected
    expect(obj).to respond_to(:foo).with(1).argument
    expect(obj).to respond_to(:bar).with(2).arguments
    expect(obj).to respond_to(:baz).with(1..2).arguments
    expect(obj).to respond_to(:xyz).with_unlimited_arguments
#Dependant on Ruby version supporting keyword arguments, one can specify list of keywords accepted
    expect(obj).to respond_to(:foo).with_keywords(:ichi, :ni)
    expect(obj).to respond_to(:bar).with(2).arguments.and_keywords(:san, :yon)
    expect(obj).to respond_to(:baz).with_arbitrary_keywords

##NOTE##
#This matcher relies on #responds_to?. if an object dynamically responds to a message with #method_missing but does not indivate this via #responds_to?, this will yield false results

#Example Scenarios

#basic usage
    RSpec.describe "a string" do
        it { is_expected.to respond_to(:length) }
        it { is_expected.to respond_to(:hash, :class, :to_s) }
        it { is_expected.not_to respond_to(:to_model) }
        it { is_expected.not_to respond_to(:compact, :flatten) }
    
        # deliberate failures
        it { is_expected.to respond_to(:to_model) }
        it { is_expected.to respond_to(:compact, :flatten) }
        it { is_expected.not_to respond_to(:length) }
        it { is_expected.not_to respond_to(:hash, :class, :to_s) }
    
        # mixed examples--String responds to :length but not :flatten
        # both specs should fail
        it { is_expected.to respond_to(:length, :flatten) }
        it { is_expected.not_to respond_to(:length, :flatten) }
    end

#specify arguements
    RSpec.describe 7 do
        it { is_expected.to respond_to(:zero?).with(0).arguments }
        it { is_expected.not_to respond_to(:zero?).with(1).argument }
    
        it { is_expected.to respond_to(:between?).with(2).arguments }
        it { is_expected.not_to respond_to(:between?).with(7).arguments }
    
        # deliberate failures
        it { is_expected.to respond_to(:zero?).with(1).argument }
        it { is_expected.not_to respond_to(:zero?).with(0).arguments }
    
        it { is_expected.to respond_to(:between?).with(7).arguments }
        it { is_expected.not_to respond_to(:between?).with(2).arguments }
    end

#specify arguments range (skip when splat args unsupported)
    class MyClass
        def build(name, options = {})
        end
    
        def inspect
            'my_object'
        end
    end
    
    RSpec.describe MyClass do
        it { is_expected.to respond_to(:build).with(1..2).arguments }
        it { is_expected.not_to respond_to(:build).with(0..1).arguments }
        it { is_expected.not_to respond_to(:build).with(2..3).arguments }
        it { is_expected.not_to respond_to(:build).with(0..3).arguments }
    
        # deliberate failures
        it { is_expected.not_to respond_to(:build).with(1..2).arguments }
        it { is_expected.to respond_to(:build).with(0..1).arguments }
        it { is_expected.to respond_to(:build).with(2..3).arguments }
        it { is_expected.to respond_to(:build).with(0..3).arguments }
    end

#specify unlimited arguments (skip when splat args unsupported)
    class MyClass
        def greet(message = 'Hello', *people)
        end
    
        def hail(person)
        end
    
        def inspect
            'my_object'
        end
    end
    
    RSpec.describe MyClass do
        it { is_expected.to respond_to(:greet).with_unlimited_arguments }
        it { is_expected.to respond_to(:greet).with(1).argument.and_unlimited_arguments }
        it { is_expected.not_to respond_to(:hail).with_unlimited_arguments }
        it { is_expected.not_to respond_to(:hail).with(1).argument.and_unlimited_arguments }
    
        # deliberate failures
        it { is_expected.not_to respond_to(:greet).with_unlimited_arguments }
        it { is_expected.not_to respond_to(:greet).with(1).argument.and_unlimited_arguments }
        it { is_expected.to respond_to(:hail).with_unlimited_arguments }
        it { is_expected.to respond_to(:hail).with(1).argument.and_unlimited_arguments }
    end

#specify keywords (skip when keywords arg unsupported)
    class MyClass
        def find(name = 'id', limit: 1_000, offset: 0)
        []
        end
    
        def inspect
            'my_object'
        end
    end
    
    RSpec.describe MyClass do
        it { is_expected.to respond_to(:find).with_keywords(:limit, :offset) }
        it { is_expected.to respond_to(:find).with(1).argument.and_keywords(:limit, :offset) }
    
        it { is_expected.not_to respond_to(:find).with_keywords(:limit, :offset, :page) }
        it { is_expected.not_to respond_to(:find).with(1).argument.and_keywords(:limit, :offset, :page) }
    
        # deliberate failures
        it { is_expected.to respond_to(:find).with_keywords(:limit, :offset, :page) }
        it { is_expected.to respond_to(:find).with(1).argument.and_keywords(:limit, :offset, :page) }
    
        it { is_expected.not_to respond_to(:find).with_keywords(:limit, :offset) }
        it { is_expected.not_to respond_to(:find).with(1).argument.and_keywords(:limit, :offset) }
    end

#specify any keywords (skip when keyword args unsupported)
    class MyClass
        def build(name: 'object', **opts)
        end
    
        def create(name: 'object', type: String)
        end
    
        def inspect
            'my_object'
        end
    end
    
    RSpec.describe MyClass do
        it { is_expected.to respond_to(:build).with_any_keywords }
        it { is_expected.to respond_to(:build).with_keywords(:name).and_any_keywords }
        it { is_expected.not_to respond_to(:create).with_any_keywords }
        it { is_expected.not_to respond_to(:create).with_keywords(:name).and_any_keywords }
    
        # deliberate failures
        it { is_expected.not_to respond_to(:build).with_any_keywords }
        it { is_expected.not_to respond_to(:build).with_keywords(:name).and_any_keywords }
        it { is_expected.to respond_to(:create).with_any_keywords }
        it { is_expected.to respond_to(:create).with_keywords(:name).and_any_keywords }
    end

#specify required keywords (skip when required keyword args unsupported)
    class MyClass
        def plant(seed:, fertilizer: nil, water: 'daily')
            []
        end
    
        def inspect
            'my_object'
        end
    end
    
    RSpec.describe MyClass do
        it { is_expected.to respond_to(:plant).with_keywords(:seed) }
        it { is_expected.to respond_to(:plant).with_keywords(:seed, :fertilizer, :water) }
        it { is_expected.not_to respond_to(:plant).with_keywords(:fertilizer, :water) }
    
        # deliberate failures
        it { is_expected.not_to respond_to(:plant).with_keywords(:seed) }
        it { is_expected.not_to respond_to(:plant).with_keywords(:seed, :fertilizer, :water) }
        it { is_expected.to respond_to(:plant).with_keywords(:fertilizer, :water) }
    end

