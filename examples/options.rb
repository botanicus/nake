#!./bin/nake

# ./examples/options.rb greet2 --name=botanicus
task(:greet2) do |options|
  puts "Hi #{options[:name]}!"
end
