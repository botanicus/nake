# encoding: utf-8

require "nake/task"

class Object
  include Nake
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
  
  def directory(path)
    FileTask.new(path) do |task|
      task.description = "Create directory #{path}"
      task.define do
        mkdir_p path
      end
    end
  end
end
