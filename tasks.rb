#!./bin/nake
# encoding: utf-8

require "nake/tasks/gem"
require "nake/tasks/spec"
require "nake/tasks/release"

Task[:build].config[:gemspec] = "nake.gemspec"
Task[:prerelease].config[:gemspec] = "nake.pre.gemspec"
Task[:release].config[:version] = Nake::VERSION
