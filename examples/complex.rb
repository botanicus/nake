#!/usr/bin/env ./bin/nake

Task.new(:release) do |task|
  task.description = "Just release it"
  task.dependencies.clear # redefine
  task.block do |*args|

  end
end
