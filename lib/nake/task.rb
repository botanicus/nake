# encoding: utf-8

require "nake/colors"

module Nake
  class Task
    def self.[](name)
      name = name.to_s
      self.tasks[name] || self.find_in_aliases(name)
    end

    # @private
    def self.find_in_aliases(name)
      _, task = self.tasks.find { |_, task| task.aliases.include?(name) }
      return task
    end

    def self.[]=(name, task)
      self.tasks[name.to_s] = task
    end

    # @protected use Task[name] resp. Task[name] = task
    def self.tasks
      @@tasks ||= Hash.new
    end

    # return existing task if task with given name already exist
    def self.new(name, *dependencies, &block)
      task = self[name]
      task && task.setup(*dependencies, &block) || super(name, *dependencies, &block)
    end

    attr_accessor :name, :description, :dependencies, :hidden, :options
    attr_reader :blocks, :aliases
    def initialize(name, *dependencies, &block)
      @aliases, @hidden = Array.new, false
      # This is a bit weird, but it's best solution
      # when we want to keep API simple and keep it
      # as one object even if it has more names
      if name.respond_to?(:join) # array
        name, *aliases = name
        self.aliases.push(*aliases)
      end
      @name, @blocks = name.to_sym, Array.new
      @dependencies  = Array.new
      self.register
      self.setup(*dependencies, &block)
    end

    def setup(*dependencies, &block)
      self.dependencies.push(*dependencies)
      self.instance_exec(self, &block) if block
      return self
    end

    def define(&block)
      @blocks.push(block)
    end

    def hidden?
      @hidden
    end

    # NOTE: the reason why we don't have splat for args is that when we have Task["-T"]
    # which doesn't have any args and options, we wall just call it without any arguments,
    # but when we use splat, then we will have to call it at least with Hash.new for options
    def call(args = Array.new, options = Hash.new)
      unless @dependencies.empty?
        puts "~ Invoking task #{name}".cyan
        self.invoke_dependencies(*args, options)
      end
      unless @blocks.empty?
        puts "~ Executing task #{name} with arguments #{args.inspect} and options #{options.inspect}".green
        @blocks.each do |block|
          if block.arity.eql?(0)
            block.call
          else
            block.call(*args, options)
          end
        end
      end
    end

    protected
    def invoke_dependencies(*args, options)
      self.dependencies.each do |name|
        task = self.class[name]
        raise TaskNotFound, "Task with name #{name} doesn't exist" if task.nil?
        task.call(*args, options) # TODO: what about arguments?
      end
    end

    def register
      self.class[self.name] = self
    end
  end
end
