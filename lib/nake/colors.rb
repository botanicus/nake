# encoding: utf-8

begin
  require "term/ansicolor"
rescue LoadError
  raise LoadError, "You have to install term-ansicolor gem!"
end

String.send(:include, Term::ANSIColor) # just for now, I know it's a mess
