# encoding: utf-8

require "nake/colors"
require "nake/argv"
require "nake/helpers"

module Nake
  TaskNotFound ||= Class.new(StandardError)
  ConfigurationError ||= Class.new(StandardError)

  class AbstractTask
    def self.[](name)
      self.tasks[name.to_s]
    end

    def self.[]=(name, task)
      self.tasks[name.to_s] = task
    end

    # @protected use Task[name] resp. Task[name] = task
    def self.tasks
      @@tasks ||= Hash.new
    end

    def self.boot
      self.tasks.each do |name, task|
        task.boot!
      end
    end

    # return existing task if task with given name already exist
    def self.new(name, *dependencies, &block)
      task = self[name]
      task && task.setup(*dependencies, &block) || super(name, *dependencies, &block)
    end

    attr_accessor :name, :dependencies, :hidden, :original_args
    attr_reader :blocks
    def initialize(name, *dependencies, &block)
      @hidden = false
      @name, @blocks = name.to_sym, Array.new
      @dependencies  = Array.new
      self.register
      self.setup(*dependencies, &block)
    end

    attr_writer :description
    def description
      if @description.respond_to?(:call)
        # task.description = lambda { "Edit #{self.config[:task_file]}" }
        @description.call
      elsif @description
        # task.description = "Edit %{task_file}"
        @description % self.config
      else
        nil
      end
    end

    attr_writer :config # don't use this if you don't have to!
    def config
      @config ||= begin
        Hash.new do |hash, key|
          raise ConfigurationError, "Configuration key #{key} in task #{name} doesn't exist"
        end.tap do |hash|
          hash.define_singleton_method(:declare) do |*keys|
            keys.each { |key| self[key] = nil unless self.has_key?(key) }
          end
        end
      end
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

    def run(args)
      self.original_args = args
      options = ArgvParser.extract!(args)
      self.call(args, options)
    end

    # NOTE: the reason why we don't have splat for args is that when we have Task["-T"]
    # which doesn't have any args and options, we wall just call it without any arguments,
    # but when we use splat, then we will have to call it at least with Hash.new for options
    def call(args = Array.new, options = Hash.new)
      unless self.dependencies.empty?
        info "Invoking task #{name}"
        self.invoke_dependencies(*args, options)
      end
      unless self.blocks.empty?
        note "Executing task #{name} with arguments #{args.inspect} and options #{options.inspect}"
        debug "Config #{self.config.inspect}"
        self.blocks.each do |block|
          block.call(*args, options)
        end
        ## we can't use arity, because it returns 0 for lambda { |options = Hash.new| }.arity
        ## if we define method with one optional argument, it will returns -1
        #
        ## better argv parsing maybe, task(:spec) do |*paths, options| is fine, but task(:spec) do |path, options| will fail if no path specified ... but actually task(:spec) do |path = "spec", options| might be fine, try it ... BTW task(["-i", "--interactive"]) do |task, *args, options| doesn't work ... putting options as a first argument should solve everything, but it's not very intuitive :/
        #if RUBY_VERSION >= "1.9.2"
        #  raise ArgumentError, "Task can't take block arguments" if args.length + 1 > block.parameters.select { |type, name| type.eql?(:req) || type.eql?(:opt) }.length
        #  raise ArgumentError, "Task can't take block arguments" if block.parameters.any? { |type, name| type.eql?(:block) }
        #end
        #
        #if RUBY_VERSION >= "1.9.2" && block.parameters.empty?
        #  block.call
        #else
        #  block.call(*args, options)
        #end
      end
    end

    def bootloaders
      @bootloaders ||= Array.new
    end

    def boot_dependencies
      @boot_dependencies ||= Array.new
    end

    def boot(*dependencies, &block)
      self.boot_dependencies.push(*dependencies)
      self.bootloaders.push(block)
    end

    def boot!
      unless self.boot_dependencies.empty? && self.bootloaders.empty?
        note "Booting #{self.name}"
      end
      while dependency = self.boot_dependencies.shift
        self.class[dependency].tap do |task|
          if task.nil?
            raise TaskNotFound, "Task #{dependency} doesn't exist!"
          end
          task.boot!
        end
      end
      while block = self.bootloaders.shift
        block.call
      end
    end

    def booted?
      self.bootloaders.empty? && self.boot_dependencies.empty?
    end

    def reset!
      self.dependencies.clear
      self.blocks.clear
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
