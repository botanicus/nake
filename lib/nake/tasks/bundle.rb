# encoding: utf-8

# NOTE: if you have bundler bundled locally, just
# add bundler/lib into $: and this task will work
Task.new(:bundle) do |task|
  task.description = "Install your gems locally from gems/cache via bundler"
  task.define do |*args, options|
    require 'rubygems'
    require 'rubygems/command'

    begin
      require 'bundler'
      require 'bundler/commands/bundle_command'
    rescue LoadError
      abort "You have to have bundler installed!"
    end

    args.push("--cached")
    Gem::Commands::BundleCommand.new.invoke(*args)
  end
end
