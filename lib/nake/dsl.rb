# encoding: utf-8

require "nake"
require "nake/task"
require "nake/file_task"

module Nake
  module DSL
    include Nake
    def argument(*names, &block)
      Nake.args[*names] = block
    end

    # desc :release, "Create a new release"
    # task(:release) do
    #   # ...
    # end
    def desc(task, description)
      Task.new(task).description = description
    end

    # Rake-style task definition
    # task(:release, :build) do |task|
    #   # task definition
    # end
    def task(name, *dependencies, &block)
      if block.nil?
        Task.new(name, *dependencies)
      else
        Task.new(name, *dependencies) do |task|
          task.define(&block)
        end
      end
    end

    def file(path, *dependencies, &block)
      if block.nil?
        FileTask.new(path, *dependencies)
      else
        FileTask.new(path, *dependencies) do |task|
          task.define(&block)
        end
      end
    end

    # rule "*.o", "*.c"
    # rule "**/*.o", "**/.c"
    def rule(pattern, *dependencies, &block)
      if block.nil?
        Rule.new(pattern, *dependencies)
      else
        Rule.new(pattern, *dependencies) do |rule|
          rule.define(&block)
        end
      end
    end

    def directory(path)
      FileTask.new(path) do |task|
        task.hidden = true # do not show in list
        task.description = "Create directory #{path}"
        task.define { mkdir_p path }
      end
    end
  end
end

class Object
  include Nake::DSL
end
