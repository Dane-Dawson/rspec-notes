#yield_control => matches if the method-under-test yields, regardless of whether or not arguments are yielded
#yield_with_args => matches if the method-under-test yields with arguments. If arguments are provided to this matcher, it will only pass if the actual yielded arguments match the expected ones using === or ==.
#yield_with_no_args => matches if the method-under-test yields with no arguments
#yield_successive_args => is designed for iterators, matching if the method-under-test yields the same number of times as arguments passed to this matcher, and all actual yielded arguments match the expected ones using === or ==.

#NOTE#
#your expect block *must* accept an argument that is then passed on to the method-under-test as a block. This acts as a "probe" that allows matcher to detect whether or not your method yields and, if so, how many times and what the yielded arguments are.

#Background class to test
    class MyClass
        def self.yield_once_with(*args)
        yield *args
        end
    
        def self.yield_twice_with(*args)
        2.times { yield *args }
        end
    
        def self.raw_yield
        yield
        end
    
        def self.dont_yield
        end
    end

#Example Scenarios

#yield_control matcher
require './my_class'

    RSpec.describe "yield_control matcher" do
        specify { expect { |b| MyClass.yield_once_with(1, &b) }.to yield_control }
        specify { expect { |b| MyClass.dont_yield(&b) }.not_to yield_control }
        specify { expect { |b| MyClass.yield_twice_with(1, &b) }.to yield_control.twice }
        specify { expect { |b| MyClass.yield_twice_with(1, &b) }.to yield_control.exactly(2).times }
        specify { expect { |b| MyClass.yield_twice_with(1, &b) }.to yield_control.at_least(1) }
        specify { expect { |b| MyClass.yield_twice_with(1, &b) }.to yield_control.at_most(3).times }

        # deliberate failures
        specify { expect { |b| MyClass.yield_once_with(1, &b) }.not_to yield_control }
        specify { expect { |b| MyClass.dont_yield(&b) }.to yield_control }
        specify { expect { |b| MyClass.yield_once_with(1, &b) }.to yield_control.at_least(2).times }
        specify { expect { |b| MyClass.yield_twice_with(1, &b) }.not_to yield_control.twice }
        specify { expect { |b| MyClass.yield_twice_with(1, &b) }.not_to yield_control.at_least(2).times }
        specify { expect { |b| MyClass.yield_twice_with(1, &b) }.not_to yield_control.at_least(1) }
        specify { expect { |b| MyClass.yield_twice_with(1, &b) }.not_to yield_control.at_most(3).times }
    end

#yield_with_args matcher
require './my_class'

    RSpec.describe "yield_with_args matcher" do
        specify { expect { |b| MyClass.yield_once_with("foo", &b) }.to yield_with_args }
        specify { expect { |b| MyClass.yield_once_with("foo", &b) }.to yield_with_args("foo") }
        specify { expect { |b| MyClass.yield_once_with("foo", &b) }.to yield_with_args(String) }
        specify { expect { |b| MyClass.yield_once_with("foo", &b) }.to yield_with_args(/oo/) }

        specify { expect { |b| MyClass.yield_once_with("foo", "bar", &b) }.to yield_with_args("foo", "bar") }
        specify { expect { |b| MyClass.yield_once_with("foo", "bar", &b) }.to yield_with_args(String, String) }
        specify { expect { |b| MyClass.yield_once_with("foo", "bar", &b) }.to yield_with_args(/fo/, /ar/) }

        specify { expect { |b| MyClass.yield_once_with("foo", "bar", &b) }.not_to yield_with_args(17, "baz") }

        # deliberate failures
        specify { expect { |b| MyClass.yield_once_with("foo", &b) }.not_to yield_with_args }
        specify { expect { |b| MyClass.yield_once_with("foo", &b) }.not_to yield_with_args("foo") }
        specify { expect { |b| MyClass.yield_once_with("foo", &b) }.not_to yield_with_args(String) }
        specify { expect { |b| MyClass.yield_once_with("foo", &b) }.not_to yield_with_args(/oo/) }
        specify { expect { |b| MyClass.yield_once_with("foo", "bar", &b) }.not_to yield_with_args("foo", "bar") }
        specify { expect { |b| MyClass.yield_once_with("foo", "bar", &b) }.to yield_with_args(17, "baz") }
    end

#yield_with_no_args matcher
require './my_class'

    RSpec.describe "yield_with_no_args matcher" do
        specify { expect { |b| MyClass.raw_yield(&b) }.to yield_with_no_args }
        specify { expect { |b| MyClass.dont_yield(&b) }.not_to yield_with_no_args }
        specify { expect { |b| MyClass.yield_once_with("a", &b) }.not_to yield_with_no_args }

        # deliberate failures
        specify { expect { |b| MyClass.raw_yield(&b) }.not_to yield_with_no_args }
        specify { expect { |b| MyClass.dont_yield(&b) }.to yield_with_no_args }
        specify { expect { |b| MyClass.yield_once_with("a", &b) }.to yield_with_no_args }
    end

#yield_successive_args matcher
    def array
        [1, 2, 3]
    end
    
    def array_of_tuples
        [[:a, :b], [:c, :d]]
    end
    
    RSpec.describe "yield_successive_args matcher" do
        specify { expect { |b| array.each(&b) }.to yield_successive_args(1, 2, 3) }
        specify { expect { |b| array_of_tuples.each(&b) }.to yield_successive_args([:a, :b], [:c, :d]) }
        specify { expect { |b| array.each(&b) }.to yield_successive_args(Integer, Integer, Integer) }
        specify { expect { |b| array.each(&b) }.not_to yield_successive_args(1, 2) }
    
        # deliberate failures
        specify { expect { |b| array.each(&b) }.not_to yield_successive_args(1, 2, 3) }
        specify { expect { |b| array_of_tuples.each(&b) }.not_to yield_successive_args([:a, :b], [:c, :d]) }
        specify { expect { |b| array.each(&b) }.not_to yield_successive_args(Integer, Integer, Integer) }
        specify { expect { |b| array.each(&b) }.to yield_successive_args(1, 2) }
    end