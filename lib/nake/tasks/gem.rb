# encoding: utf-8

require "nake/dsl"
require "nake/tasks/clean"

# register gem files for cleaning
Task[:clean].config[:files].push(*Dir["*.gem"])

module Nake::PackageMixin
  def gem_name
    "#{Task[:release].config[:name]}-#{Task[:release].config[:version]}.gem"
  end
end

# require "nake/tasks/gem"
# Task[:build].config[:gemspec] = Dir["*.gemspec"]
Task.new(:build) do |task|
  task.define do
    sh "gem build #{task.config[:gemspec]}"
  end
end

Task.new(:install, :build) do |task|
  task.extend(PackageMixin)
  task.description = "Install"
  task.define do
    sh "gem install #{self.gem_name}"
  end
end
