#!./bin/nake

task(:greet2) do |user = ENV["USER"]|
  puts "Hi #{user}!"
end
