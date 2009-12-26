# encoding: utf-8

require "nake/tasks/gem"

# require "nake/tasks/release"
# Task[:release].config[:version] = Nake::VERSION
task(:release, "release:tag", "release:gemcutter").tap do |task|
  task.description = "Release current version version"
  task.define do
    puts "Version #{version} was successfuly published. Don't forget to increase VERSION constant!"
  end
end

task(:prerelease).tap do |task|
  task.description = "Update prerelease version"
  task.define do
    Task[:release].config[:version] = "#{Task[:release].config[:version]}.pre"
    Task["release:gemcutter"].call
  end
end

Task.new("release:tag") do |task|
  task.description = "Create Git tag"
  task.define do
    version = Task[:release].config[:version]
    raise ConfigurationError, "You have to provide Task[:release].config[:version]!" if version.nil?
    puts "Creating new git tag #{version} and pushing it online ..."
    sh "git tag -a -m 'Version #{version}' #{version}"
    sh "git push --tags"
    puts "Tag #{version} was created and pushed to GitHub."
  end
end

Task.new("release:gemcutter") do |task|
  task.description  = "Push gem to Gemcutter"
  task.dependencies = [:clean, :build]
  task.define do
    task.config[:gem] = "#{Task[:build].config[:gemspec]}-#{Task[:release].config[:version]}.gem"
    puts "Pushing to Gemcutter ..."
    sh "gem push #{task.config[:gem]}"
  end
end
