# encoding: utf-8

require "nake/dsl"

# require "nake/tasks/clean"
# Task[:clean].config[:files] = Dir["*.gem"]
Task.new(:clean) do |task|
  task.config[:files] = Array.new
  task.define do
    task.config[:files].each { |file| rm_f file }
  end
end
