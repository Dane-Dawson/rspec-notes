class Thingdoer
    #The first test is set to see if the method equals "Hello"
    def hello
        "Hello"
    end

    #This test fails the previous test, because although the output is "Hello", the method itself does not equal "Hello". The test has been changed to pass by altering the expect().to into expect().not_to
    def hello_fail
        puts "Hello"
    end

    #This test shows a way to use include testing. Use include to specify that a collection includes one or more expected objects. Note that even though there are two entries, include only tests if *any* object passes the condition
    def say_hello
        message = ["Hello", "there"]
    end
end