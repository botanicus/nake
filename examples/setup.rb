#!/usr/bin/env ./bin/nake

# NOTE: this isn't implemented yet!
# THERE MIGHT TO BE USEFUL TO HAVE BASE CLASS FOR TASK, BECAUSE FILE TASK DOESN'T HAVE ALIASES ETC
Task.new(:build) do |task|
  task.description = "Release version #{Task[:release].config[:version]}" # but release task might not exist yet
end

# soo ...
Task.new(:build) do |task|
  task.setup do |variable|
    task.description = "Release version #{Task[:release].config[:version]}"
  end
end

# hodi se hlavne pro descriptions a pro pushovani veci do dependencies, protoze z dependencies se daji odstranit, kdezto z procu, kde se invokujou explicitne, to jde fakt tezko
# setup task se vola na zacatku Nake.run

# advanced ...
Task.new(:build) do |task|
  task.setup(:release, :other_task) do |variable|
    task.description = "Release version #{Task[:release].config[:version]}"
  end
end
