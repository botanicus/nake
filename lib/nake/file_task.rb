# encoding: utf-8

require "nake/task"

module Nake
  class FileTask < Task
    def call(args = Array.new, options = Hash.new)
      unless self.dependencies.empty?
        puts "~ Invoking file task #{name}".cyan
        will_run = self.invoke_dependencies(*args, options)
      end
      if will_run && ! self.blocks.empty?
        puts "~ Executing file task #{name} with arguments #{args.inspect} and options #{options.inspect}".green
        self.blocks.each do |block|
          if block.arity.eql?(0)
            block.call
          else
            block.call(*args, options)
          end
        end
      end
    end

    protected
    # return true if the task need to be executed, false otherwise
    def invoke_dependencies(*args, options)
      self.dependencies.all? do |name|
        task = self.class[name] # first try if there is a task with given name
        task.call(*args, options) # TODO: what about arguments?
        File.exist?(name) # if not, then fallback to file
        File.mtime(name) < File.mtime(self.name)
      end
    end
  end
end
