#!/usr/bin/env ./bin/nake

# You might want to give more useful description, however you don't have access
# to some variables so far ... at least with Rake. Nake provides boot method which
# run after everything is loaded, and if you specify optional dependencies for the
# boot method, it will run the boot block of specified tasks first. This might come
# handy time to time, but usually it's enough to use it without arguments since you
# usually need just to load the whole task file where is all the configuration.

# Typical usecases:
# - you want to provide concrete info in description
# - you need to access configuration of a task on other place than in the define block

Task.new(:build) do |task|
  task.boot(:release) do
    task.description = "Release version #{Task[:release].config[:version]}"
  end
end
