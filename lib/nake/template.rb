# encoding: utf-8

module Nake
  module TaskHelpers
    def template(source, target, context = Hash.new)
      template = Template.new(source)
      File.open(target, "w") do |file|
        file.puts(template.render(context))
      end
    end

    def erb(source, target, context = Hash.new)
      template = ErbTemplate.new(source)
      File.open(target, "w") do |file|
        file.puts(template.render(context))
      end
    end
  end

  class Template
    def initialize(path)
      @path = path
    end

    def render(context = Hash.new)
      File.read(@path) % context
    end
  end

  class ErbTemplate
    def initialize(path)
      require "erb"
      @path = path
    end

    def set_locals(context)
      context.inject("") do |source, pair|
        source += "#{pair.first} = context[:#{pair.first}]\n"
      end
    end

    def source(context)
      ["<% #{self.set_locals(context)} %>", File.read(@path)].join("")
    end

    def render(context = Hash.new)
      template = ERB.new(self.source(context))
      template.result(binding)
    end
  end
end
