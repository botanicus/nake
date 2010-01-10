# encoding: utf-8

begin
  require "term/ansicolor"
rescue LoadError
  raise LoadError, "You have to install term-ansicolor gem!"
end

String.send(:include, Term::ANSIColor) # just for now, I know it's a mess

module Term::ANSIColor
  def self.coloring?
    if @coloring.respond_to?(:call)
      @coloring.call
    else
      @coloring
    end
  end
end


Term::ANSIColor.coloring = lambda { Nake.coloring }
