# encoding: utf-8

require "nake/dsl"
require "nake/tasks/clean"

# register gem files for cleaning
Task[:clean].config[:files].push(*Dir["*.gem"])

# require "nake/tasks/gem"
# Task[:build].config[:gemspec] = Dir["*.gemspec"]
Task.new(:build) do |task|
  task.define do
    exec "gem build #{task.config[:gemspec]}"
  end
end
