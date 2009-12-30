#!/usr/bin/env ./bin/nake

task(:greet) do
  puts "Hi #{ENV["USER"]}!"
end
