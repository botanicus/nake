# encoding: utf-8

require "nake/task"

# NOTE: if you have bundler bundled locally, just
# add bundler/lib into $: and this task will work
Nake::Task.new(:bundle) do |task|
  task.description = "Install your gems locally from gems/cache via bundler"

  # define bundler method, so we can test it
  task.define_singleton_method(:bundler) do
    @bundler ||= Gem::Commands::BundleCommand.new
  end

  # task definition
  task.define do |*args, options|
    require 'rubygems'
    require 'rubygems/command'

    begin
      require 'bundler'
      require 'bundler/commands/bundle_command'
    rescue LoadError
      abort "You have to have bundler installed!"
    end

    args.push("--cached") unless options.delete[:cached]
    self.bundler.invoke(*task.original_args)
  end
end
