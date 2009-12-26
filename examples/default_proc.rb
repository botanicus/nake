#!./bin/nake

# Default value returned from Task["not_existing_task"] don't have to be even a task,
# it just have to respond to #call, so you can use Hash#default_proc=(proc) as well
# Just make sure you are wrap the callable object in lambda, because the callable
# object has to be returned as a result from the finding on the hash, but the
# default proc is what is actually called if nothing is found.
# You might i. e. customize error message or you might detect desired task in runtime.
Task.tasks.default_proc = lambda do |tasks, name|
  lambda { |*args| abort("Task #{name} executed with args: #{args.inspect}") }
end
