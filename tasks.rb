#!./bin/nake
# encoding: utf-8

begin
  require File.expand_path("../.bundle/environment", __FILE__)
rescue LoadError
  require "bundler"
  Bundler.setup
end

$LOAD_PATH.unshift(File.expand_path("../lib", __FILE__))

require "nake/tasks/gem"
require "nake/tasks/spec"
require "nake/tasks/release"

begin
  load "code-cleaner.nake"
  Nake::Task["hooks:whitespace:install"].tap do |task|
    task.config[:encoding] = "utf-8"
    task.config[:whitelist] = '(bin/[^/]+|.+\.(rb|rake|nake|thor|task))$'
  end
rescue LoadError
  warn "If you want to contribute to nake, you have to install code-cleaner gem and then run ./tasks.rb hooks:whitespace:install to get Git pre-commit hook for removing trailing whitespace and improving code quality in general."
end

Task[:build].config[:gemspec] = "nake.gemspec"
Task[:prerelease].config[:gemspec] = "nake.pre.gemspec"
Task[:release].config[:name] = "nake"
Task[:release].config[:version] = Nake::VERSION

Task.new(:features) do |task|
  task.description = "Run cucumber scenarios"
  task.define do
    sh "cucumber features"
  end
end

Task.new(:bm) do |task|
  task.description = "Run benchmarks"
  task.define do
    load "#{File.dirname(__FILE__)}/bm/bms.rb"
  end
end

Task.new("bm:save") do |task|
  task.description = "Run benchmarks"
  task.define do
    sh "ruby bm/bms.rb > bm/output.txt"
  end
end
