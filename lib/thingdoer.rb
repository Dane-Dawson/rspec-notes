class Thingdoer
    #The first test is set to see if the method equals "Hello". This works because Ruby implicitly returns 
    def hello
        "Hello"
    end

    #This second function has the same test written and also passes.
    def return_hello
        return "Hello"
    end

    #One more example to show that the last string in the function is the one returned, the test for this function checks for "Goodbye".
    def return_goodbye
        "Hello"
        "and"
        "Goodbye"
    end

    #This test fails with the the previous testing parameter, because although it puts "Hello", the method itself does not return "Hello". The test has been changed to pass by altering the expect().to into expect().not_to
    def hello_fail
        puts "Hello"
    end

    #This test shows a way to use include testing. Use include to specify that a collection includes one or more expected objects. Note that even though there are two entries, include only tests if *any* object passes the condition
    def say_hello
        message = ["Hello", "and", "Goodbye"]
    end

end