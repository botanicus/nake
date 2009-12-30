#!/usr/bin/env ./bin/nake

# this will be probably in a library
Task.new(:build) do |task|
  task.define do
    sh "gem build #{task.config[:gemspec]}"
  end
end

# and this in your file with tasks
Task[:build].config[:gemspec] = "nake.gemspec"

# if the task isn't defined yet
task(:mytask)
Task[:mytask].config[:name] = "foo"
