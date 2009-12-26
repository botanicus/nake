#!./bin/nake

# When you run rake without arguments, it will try to run task called default.
# Since I don't believe in any stupid convention, I don't support anything similar,
# because you can do it just using standard Ruby methods like Hash#default=(value)
# Of course the task which you are assigning as a default have to already exist,
# so you have to put this to the end of your file or you might want to use
# Hash#default_proc=(proc) as described in examples/default_proc.rb like:
# Task.tasks.default_proc = lambda { |*| Task[:build] }
Task.tasks.default = Task["-T"]
