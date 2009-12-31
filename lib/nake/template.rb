# encoding: utf-8

module Nake
  module TaskHelpers
    def template(source, target, context = Hash.new)
      template = Template.new(source)
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
end
