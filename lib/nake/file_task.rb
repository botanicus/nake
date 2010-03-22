# encoding: utf-8

require "nake/abstract_task"

module Nake
  class FileTask < AbstractTask
    # TODO: default description na Generate #name
    alias_method :path, :name

    # FileTask can depend on tasks, other file tasks or just files.
    # If a file task depends on a task, this task isn't supposed to change anything what ...
    # ... if it's changing something, make sure the changing task is actually called before the file tasks are executed
    # If the task is changing something so the file will be generated in all cases, you should rather to use normal task
    # If there are some dependencies on files
    # FileTask.new("www/index.html") do |task|
    #   task.file_dependencies.push(*FileList["images/**/*"])
    #   task.dependencies.push("www") # www task exist
    # end
    def call(args = Array.new, options = Hash.new)
      will_run = true
      unless self.dependencies.empty?
        info "Invoking file task #{name}"
        will_run = self.invoke_dependencies(*args, options)
      end
      if will_run && ! self.blocks.empty?
        note "Executing file task #{name} with arguments #{args.inspect} and options #{options.inspect}"
        debug "Config #{self.config.inspect}"
        self.blocks.each do |block|
          block.call(self.path, *args, options)
        end
      else
        warn "File task #{name} won't be executed"
      end
    end

    protected
    # task will be executed just if
    def will_run?
      file_tasks = self.dependencies.select { |name| self.class[name] }
      file_tasks.any? do |path|

      end
    end

    def task_will_run?(path)
      File.exist?(path) || File.mtime(path) < File.mtime(self.name)
    end

    # return true if the task need to be executed, false otherwise
    def invoke_dependencies(*args, options)
      self.dependencies.each do |name|
        if task = self.class[name] # first try if there is a task with given name
          task.call(*args, options) # TODO: what about arguments?
        elsif File.exist?(name) # if not, then fallback to file
          task_will_run?(name)
        else
          raise TaskNotFound, "Task with name #{name} doesn't exist"
        end
      end
    end
  end
end
