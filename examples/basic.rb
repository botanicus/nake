#!./bin/nake

# simple
task(:greet1) do
  puts "Hi #{ENV["USER"]}!"
end

