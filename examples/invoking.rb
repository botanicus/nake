#!./bin/nake

task(:foo) do
  Task[:bar].call
end
