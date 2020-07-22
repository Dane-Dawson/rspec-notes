#Example of all "be" matchers
    expect(obj).to be_truthy  # passes if obj is truthy (not nil or false)
    expect(obj).to be_falsey  # passes if obj is falsy (nil or false)
    expect(obj).to be_nil     # passes if obj is nil
    expect(obj).to be         # passes if obj is truthy (not nil or false)

#Example scenarios

#be_truthy
    RSpec.describe "be_truthy matcher" do
        specify { expect(true).to be_truthy }
        specify { expect(7).to be_truthy }
        specify { expect("foo").to be_truthy }
        specify { expect(nil).not_to be_truthy }
        specify { expect(false).not_to be_truthy }
    
        # deliberate failures
        specify { expect(true).not_to be_truthy }
        specify { expect(7).not_to be_truthy }
        specify { expect("foo").not_to be_truthy }
        specify { expect(nil).to be_truthy }
        specify { expect(false).to be_truthy }
    end

#be_falsey
    RSpec.describe "be_falsey matcher" do
        specify { expect(nil).to be_falsey }
        specify { expect(false).to be_falsey }
        specify { expect(true).not_to be_falsey }
        specify { expect(7).not_to be_falsey }
        specify { expect("foo").not_to be_falsey }
    
        # deliberate failures
        specify { expect(nil).not_to be_falsey }
        specify { expect(false).not_to be_falsey }
        specify { expect(true).to be_falsey }
        specify { expect(7).to be_falsey }
        specify { expect("foo").to be_falsey }
    end

#be_nil
    RSpec.describe "be_nil matcher" do
        specify { expect(nil).to be_nil }
        specify { expect(false).not_to be_nil }
        specify { expect(true).not_to be_nil }
        specify { expect(7).not_to be_nil }
        specify { expect("foo").not_to be_nil }
    
        # deliberate failures
        specify { expect(nil).not_to be_nil }
        specify { expect(false).to be_nil }
        specify { expect(true).to be_nil }
        specify { expect(7).to be_nil }
        specify { expect("foo").to be_nil }
    end

    #be
    RSpec.describe "be_matcher" do
        specify { expect(true).to be }
        specify { expect(7).to be }
        specify { expect("foo").to be }
        specify { expect(nil).not_to be }
        specify { expect(false).not_to be }
    
        # deliberate failures
        specify { expect(true).not_to be }
        specify { expect(7).not_to be }
        specify { expect("foo").not_to be }
        specify { expect(nil).to be }
        specify { expect(false).to be }
    end