# encoding: utf-8

module Nake
  # VERSION ||= "0.0.8.1"
  def self.verbose
    @@verbose
  rescue NameError
    @@verbose = true
  end

  def self.verbose=(boolean)
    @@verbose = boolean
  end

  def self.debug
    @@debug
  rescue NameError
    @@debug = true
  end

  def self.debug=(boolean)
    @@debug = boolean
  end

  def self.coloring
    @@coloring
  rescue NameError
    @@coloring = STDIN.tty?
  end

  def self.coloring=(boolean)
    @@coloring = boolean
  end

  # I was drunk so you might found this code not very clear. But it's clear for me and it works.
  def self.args
    @@args ||= begin
      Hash.new.tap do |hash|
        hash.define_singleton_method(:[]) do |name|
          names, value = self.find { |names, block| names.include?(name) }
          return value
        end

        hash.define_singleton_method(:[]=) do |*names, proc|
          super(names, proc)
        end
      end
    end
  end

  def self.parse(args = ARGV)
    default = {nake: Array.new, task: Array.new}
    args.inject(default) do |hash, argument|
      if argument.match(/^-/) && hash[:task].empty?
        hash[:nake].push(argument)
      elsif File.exist?(argument) && hash[:file].nil? # just the first one
        hash[:file] = argument
      else
        hash[:task].push(argument)
      end
      hash
    end
  end

  def self.run_args
    # TODO: proceed --debug and --verbose first! ... to by slo tak, ze by se iterovalo pres Nake.args a pokud je to pritomno tak proved
    Nake.parse[:nake].each do |argument|
      unless self.args[argument]
        abort "Unrecognized argument: #{argument}"
      end
      name, value = ArgvParser.parse(argument)
      if name
        info "Invoking argument #{argument} with #{name} = #{value}"
        self.args[argument].call(name, value)
      else
        info "Invoking argument #{argument} without any arguments"
        self.args[argument].call
      end
    end
  end

  # Run first task
  #
  # @raise [TaskNotFound]
  # @example
  #   Nake.run(["release"])
  # @since 0.0.1
  # @author Jakub Stastny
  def self.run_task
    Task.boot
    name, *args = Nake.parse[:task]
    task = Task[name]
    if name.nil?
      raise TaskNotFound, "You have to specify a task you want to run!"
    elsif task.nil?
      raise TaskNotFound, "Task with name #{name} doesn't exist"
    else
      task.run(args)
    end
  end
end

require "nake/task"
