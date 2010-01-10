# encoding: utf-8

require "nake/abstract_task"

module Nake
  class Rule < AbstractTask
    undef_method :hidden, :hidden=
    class << self
      undef_method :tasks
    end

    def self.rules
      @@rules ||= Hash.new
    end

    # Rule["test.o"]
    # # => rule with pattern ".o"
    def self.[](file)
      self.rules.find { |rule| rule.match?(file.to_s) }
    end

    def self.[]=(pattern, rule)
      self.rules[pattern.to_s] = rule
    end

    alias_method :pattern, :name
    def match?(file)
      #
    end
  end

  # Somewhat like method_missing:
  # If you can't find a task, try to look for a rule
  AbstractTask.tasks.default_proc = lambda { |hash, name| Rule[name] }
end
