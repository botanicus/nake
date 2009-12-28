#!./bin/nake
# encoding: utf-8

require "nake/tasks/gem"
require "nake/tasks/spec"
require "nake/tasks/release"

begin
  load "code-cleaner.nake"
rescue LoadError
  warn "If you want to contribute to nake, you have to install code-cleaner gem and then run ./tasks.rb hooks:whitespace:install to get Git pre-commit hook for removing trailing whitespace and improving code quality in general."
end

Task[:build].config[:gemspec] = "nake.gemspec"
Task[:prerelease].config[:gemspec] = "nake.pre.gemspec"
Task[:release].config[:name] = "nake"
Task[:release].config[:version] = Nake::VERSION
