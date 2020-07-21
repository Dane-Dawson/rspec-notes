# rspec-notes
Notes on rspec, example tests


- Rspec -

Domain Specific Language (DSL) testing tool written in 2007 to test Ruby code.

BDD - Behavior Driven Development

-Agile devopment process


```
RSpec.describe ClassObject do
  it "Generates a new ClassObject with name Hello World" do
    newObject = ClassObject.create(:name => "Hello World")
    
    expect(newObject.name).to eq("Hello World")
  end
end
```