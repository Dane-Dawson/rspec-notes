# rspec-notes
Notes on rspec, example tests


- Rspec -

Domain Specific Language (DSL) testing tool written in 2007 to test Ruby code.

BDD - Behavior Driven Development
-Write code for the activities/actions you want done, little concern for active testing during as results throughout will show you are in the right direction
TDD - Test Driven Development
-Write a test for what you want to have happen, then write the least amount of code possible/necessary to accomplish passing that test.

-Agile devopment process


```
RSpec.describe ClassObject do
    describe '#new' do
        it "Generates a new ClassObject with name Hello World" do
            newObject = ClassObject.create(:name => "Hello World")
    
            expect(newObject.name).to eq("Hello World")
        end
    end
end
```

The describe method creates an ExampleGroup, and within that block one can declare examples using the "it" method which become test cases. On a base level, the example group is a class inwhich the block passed is evaluated, each "it" is evaluated within the context of a unique instance of that class.