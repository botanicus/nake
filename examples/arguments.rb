#!/usr/bin/env ./bin/nake --debug

# This example document how you can change different flags
# - specify these flags in shebang
# - use API directly
# - ./examples/flags --verbose
Nake.verbose = false

# Arguments might be considered as a light-weight variant to tasks
# There are two ways how you can use tasks:
# 1) as a filter, just set a variable --debug
# 2) add your own functionality and then use exit
# 3) just set the task which will run afterwards
Nake.args["-H", "--help"] = lambda { Kernel.abort("This is my customized help!") }

task(:tasks) { puts "Available tasks: #{Nake::Task.tasks.keys.join(", ")}" }
Nake.args["-T", "--tasks"] = lambda { |*| Nake.parse[:task].clear.push("tasks") }

argument("--debug", "--no-debug") do |key, value|
  puts "~ Setting #{key} to #{value}"
  Nake.debug = value
end

# ./examples/arguments.rb --report greet
# ./examples/arguments.rb --report wait
task(:greet) { puts "Hey mate!" }
task(:wait)  { sleep(1) }

argument("--report") do |*|
  @before = Time.now
  at_exit do
    task = Nake.parse[:task].first
    time = Time.now - @before
    puts "Running task #{task} took #{time} seconds"
  end
end

# TODO: execution order, argument helper + args passing to the proc
