#!/usr/bin/env ./bin/nake

task(:greet) do |user, options| # FIXME: this doesn't work if you don't specify any args
  puts "Hi #{user}!"
end

task(:greet) do |user = ENV["USER"], options|
  puts "Hi #{user}!"
end

# ./examples/task_arguments.rb greet:options
# ./examples/task_arguments.rb greet:options --name=botanicus
# ./examples/task_arguments.rb greet:options foo bar --name=botanicus
task("greet:options") do |*, options|
  raise ArgumentError, "You have to specify --name=#{ENV["USER"]}" if options.empty?
  puts "Hi #{options[:name]}!"
end

## ./examples/task_arguments.rb greet:options --name=botanicus
#task("greet:options") do |user, options|
#  case options[:type]
#  when :friendly
#    puts "Hi mate!"
#  else
#    puts "Hi #{user}!"
#  end
#end
