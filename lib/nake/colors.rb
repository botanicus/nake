# encoding: utf-8

begin
  require "term/ansicolor"
rescue LoadError
  raise LoadError, "You have to install term-ansicolor gem!"
end

String.send(:include, Term::ANSIColor) # just for now, I know it's a mess

# show colors just if you run nake directly from command line,
# but not if are using nake in a script or so
Term::ANSIColor.coloring = STDIN.tty?
