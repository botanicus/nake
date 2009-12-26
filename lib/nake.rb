# encoding: utf-8

require "nake/task"

module Nake
  VERSION ||= "0.0.4"
  TaskNotFound ||= Class.new(StandardError)
  ConfigurationError ||= Class.new(StandardError)

  def self.run(args = ARGV)
    name = args.shift
    task = Task[name]
    if name && task.nil?
      raise TaskNotFound, "Task with name #{name} doesn't exist"
    elsif name.nil? && task.nil?
      raise TaskNotFound, "You have to specify a task you want to run!"
    else
      task.run(args)
    end
  end
end

require "nake/dsl"
require "nake/helpers"
require "nake/tasks"
require "nake/colors"
