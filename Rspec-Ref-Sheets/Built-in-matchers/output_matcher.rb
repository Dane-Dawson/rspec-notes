#provides a way to asset the block as emitted content to either $stdout or $stderr

#with no argument given passes if block outputs to_stdout or to_stderr.
#with string, passes if the blocks outputs that specific string to_stdout or to_stderr.
#with regex or matcher, passes if the blocks outputs a string to_stdout or to_stderr that matches.

#to capture output from any spawned subprocess as well, use to_stdout_from_any_process or to_stderr_from_any_process. Output from any process that inherits themain process's corresponding standard stream with be captured.

#NOTE#
#to_stdout_from_any_process or to_stderr_from_any_process uses tempfiles to capture output and thus are significantly slower than to_stdout and to_stderr

#Example Scenarios

#output_to_stdout matcher
    RSpec.describe "output.to_stdout matcher" do
        specify { expect { print('foo') }.to output.to_stdout }
        specify { expect { print('foo') }.to output('foo').to_stdout }
        specify { expect { print('foo') }.to output(/foo/).to_stdout }
        specify { expect { }.to_not output.to_stdout }
        specify { expect { print('foo') }.to_not output('bar').to_stdout }
        specify { expect { print('foo') }.to_not output(/bar/).to_stdout }
    
        # deliberate failures
        specify { expect { }.to output.to_stdout }
        specify { expect { }.to output('foo').to_stdout }
        specify { expect { print('foo') }.to_not output.to_stdout }
        specify { expect { print('foo') }.to output('bar').to_stdout }
        specify { expect { print('foo') }.to output(/bar/).to_stdout }
    end
    
#output_to_stderr matcher
    RSpec.describe "output_to_stderr matcher" do
        specify { expect { warn('foo') }.to output.to_stderr }
        specify { expect { warn('foo') }.to output("foo\n").to_stderr }
        specify { expect { warn('foo') }.to output(/foo/).to_stderr }
        specify { expect { }.to_not output.to_stderr }
        specify { expect { warn('foo') }.to_not output('bar').to_stderr }
        specify { expect { warn('foo') }.to_not output(/bar/).to_stderr }

        # deliberate failures
        specify { expect { }.to output.to_stderr }
        specify { expect { }.to output('foo').to_stderr }
        specify { expect { warn('foo') }.to_not output.to_stderr }
        specify { expect { warn('foo') }.to output('bar').to_stderr }
        specify { expect { warn('foo') }.to output(/bar/).to_stderr }
    end

#output_to_stdout_from_any_process matcher
    RSpec.describe "output.to_stdout_from_any_process matcher" do
        specify { expect { system('printf foo') }.to output.to_stdout_from_any_process }
        specify { expect { system('printf foo') }.to output("foo").to_stdout_from_any_process }
        specify { expect { system('printf foo') }.to output(/foo/).to_stdout_from_any_process }
        specify { expect { }.to_not output.to_stdout_from_any_process }
        specify { expect { system('printf foo') }.to_not output("bar").to_stdout_from_any_process }
        specify { expect { system('printf foo') }.to_not output(/bar/).to_stdout_from_any_process }

        # deliberate failures
        specify { expect { }.to output.to_stdout_from_any_process }
        specify { expect { }.to output('foo').to_stdout_from_any_process }
        specify { expect { system('printf foo') }.to_not output.to_stdout_from_any_process }
        specify { expect { system('printf foo') }.to output('bar').to_stdout_from_any_process }
        specify { expect { system('printf foo') }.to output(/bar/).to_stdout_from_any_process }
    end

#output_to_stderr_from_any_process matcher
    RSpec.describe "output.to_stderr_from_any_process matcher" do
        specify { expect { system('printf foo 1>&2') }.to output.to_stderr_from_any_process }
        specify { expect { system('printf foo 1>&2') }.to output("foo").to_stderr_from_any_process }
        specify { expect { system('printf foo 1>&2') }.to output(/foo/).to_stderr_from_any_process }
        specify { expect { }.to_not output.to_stderr_from_any_process }
        specify { expect { system('printf foo 1>&2') }.to_not output("bar").to_stderr_from_any_process }
        specify { expect { system('printf foo 1>&2') }.to_not output(/bar/).to_stderr_from_any_process }

        # deliberate failures
        specify { expect { }.to output.to_stderr_from_any_process }
        specify { expect { }.to output('foo').to_stderr_from_any_process }
        specify { expect { system('printf foo 1>&2') }.to_not output.to_stderr_from_any_process }
        specify { expect { system('printf foo 1>&2') }.to output('bar').to_stderr_from_any_process }
        specify { expect { system('printf foo 1>&2') }.to output(/bar/).to_stderr_from_any_process }
    end