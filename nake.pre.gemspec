#!/usr/bin/env gem build
# encoding: utf-8

# You might think this is a terrible mess and guess what, you're
# right mate! However say thanks to authors of RubyGems, not me.
eval(File.read("nake.gemspec")).tap do |specification|
  specification.version = "#{Nake::VERSION}.pre"
end
