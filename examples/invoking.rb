#!/usr/bin/env ./bin/nake

task(:inspect) do |*args, options|
  puts "Arguments: #{args.inspect}"
  puts "Options: #{options.inspect}"
end

task(:foo) do
  Task[:inspect].call
end

task(:bar) do |*args, options|
  Task[:inspect].call(*args, options)
end
