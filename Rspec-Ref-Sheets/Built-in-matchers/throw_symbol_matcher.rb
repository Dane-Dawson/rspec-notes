#used to specify that a block of code throws a symbol, most basic form passes if any symbol is thrown
    expect { throw :foo }.to throw_symbol   
#to specify a particular symbol
    expect { throw :foo }.to throw_symbol(:foo)
#can also specify arguments
    expect { throw :foo, 7 }.to throw_symbol(:foo, 7)

#Example Scenarios

#basic usage
    RSpec.describe "throw" do
        specify { expect { throw :foo    }.to     throw_symbol }
        specify { expect { throw :bar, 7 }.to     throw_symbol }
        specify { expect { 5 + 5         }.not_to throw_symbol }
    
        # deliberate failures
        specify { expect { throw :foo    }.not_to throw_symbol }
        specify { expect { throw :bar, 7 }.not_to throw_symbol }
        specify { expect { 5 + 5         }.to     throw_symbol }
    end

#specify symbol thrown
    RSpec.describe "throw symbol" do
        specify { expect { throw :foo    }.to     throw_symbol(:foo) }
        specify { expect { throw :foo, 7 }.to     throw_symbol(:foo) }
        specify { expect { 5 + 5         }.not_to throw_symbol(:foo) }
        specify { expect { throw :bar    }.not_to throw_symbol(:foo) }
    
        # deliberate failures
        specify { expect { throw :foo    }.not_to throw_symbol(:foo) }
        specify { expect { throw :foo, 7 }.not_to throw_symbol(:foo) }
        specify { expect { 5 + 5         }.to     throw_symbol(:foo) }
        specify { expect { throw :bar    }.to     throw_symbol(:foo) }
    end

#specify thrown symbol and argument
    RSpec.describe "throw symbol with argument" do
        specify { expect { throw :foo, 7 }.to     throw_symbol(:foo, 7) }
        specify { expect { throw :foo, 8 }.not_to throw_symbol(:foo, 7) }
        specify { expect { throw :bar, 7 }.not_to throw_symbol(:foo, 7) }
        specify { expect { throw :foo    }.not_to throw_symbol(:foo, 7) }
    
        # deliberate failures
        specify { expect { throw :foo, 7 }.not_to throw_symbol(:foo, 7) }
        specify { expect { throw :foo, 8 }.to     throw_symbol(:foo, 7) }
        specify { expect { throw :bar, 7 }.to     throw_symbol(:foo, 7) }
        specify { expect { throw :foo    }.to     throw_symbol(:foo, 7) }
    end
  