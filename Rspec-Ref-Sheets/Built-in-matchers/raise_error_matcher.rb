#used to specify that a block of code raises an error. Most basic form passes if any error is thrown

    expect { raise StandardError }.to raise_error

#This wording is also functional, by preference

    expect { 3 / 0 }.to raise_exception

#There are also a number of ways to specify details of error/exception

    expect { raise "oops" }.to raise_error
    expect { raise "oops" }.to raise_error(RuntimeError)
    expect { raise "oops" }.to raise_error("oops")
    expect { raise "oops" }.to raise_error(/op/)
    expect { raise "oops" }.to raise_error(RuntimeError, "oops")
    expect { raise "oops" }.to raise_error(RuntimeError, /op/)
    expect { raise "oops" }.to raise_error(an_instance_of(RuntimeError).and having_attributes(message: "oops"))

#Example Scenarios

#expect any error
    RSpec.describe "calling a missing method" do
        it "raises" do
            expect { Object.new.foo }.to raise_error
        end
    end

#expect specific error
    RSpec.describe "calling a missing method" do
        it "raises" do
            expect { Object.new.foo }.to raise_error(NameError)
        end
    end

#match message with a string
    RSpec.describe "matching error message with string" do
        it "matches the error message" do
            expect { raise StandardError, 'this message exactly'}.
                to raise_error('this message exactly')
        end
    end

#match message with a regexp
    RSpec.describe "matching error message with regex" do
        it "matches the error message" do
            expect { raise StandardError, "my message" }.
                to raise_error(/my mess/)
        end
    end

#matching message with 'with_message'
    RSpec.describe "matching error message with regex" do
        it "matches the error message" do
            expect { raise StandardError, "my message" }.
                to raise_error.with_message(/my mess/)
        end
    end

#match class + message with string
    RSpec.describe "matching error message with string" do
        it "matches the error message" do
            expect { raise StandardError, 'this message exactly'}.
                to raise_error(StandardError, 'this message exactly')
        end
    end

#match class + message with regex
    RSpec.describe "matching error message with regex" do
        it "matches the error message" do
            expect { raise StandardError, "my message" }.
                to raise_error(StandardError, /my mess/)
        end
    end

#set expectations on error object passed to block
    RSpec.describe "#foo" do
        it "raises NameError" do
            expect { Object.new.foo }.to raise_error { |error|
            expect(error).to be_a(NameError)
            }
        end
    end

#set expectations on error object with chained matchers
    RSpec.describe "composing matchers" do
        it "raises StandardError" do
            expect { raise StandardError, "my message" }.
                to raise_error(an_instance_of(StandardError).and having_attributes({"message" => "my message"}))
        end
    end

#expect no error at all
    RSpec.describe "#to_s" do
        it "does not raise" do
            expect { Object.new.to_s }.not_to raise_error
        end
    end