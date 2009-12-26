#!/usr/bin/env ruby --disable-gems

# This file shows how to run Nake from API. In most of cases you don't
# need this and you might want to use just shebang with env, but this
# might come handy if you need to pass some arguments for Ruby.
$:.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "nake"

# task definitions
task("greet:all") do
  puts "Hey guys!"
end

# run nake
begin
  Nake.run(ARGV)
rescue TaskNotFound => exception
  abort "[#{"ERROR".red}] #{exception.message}"
end
