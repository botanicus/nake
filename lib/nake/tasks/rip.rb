# encoding: utf-8

begin
  require "recho"
rescue LoadError
  raise LoadError, "This task require recho gem!"
end

require "nake/file_task"

# FileTask["deps.rip"].config[:versions] = {rack: "1.0.1", media_path: "SHA1"}

# register task
#Task[:release].dependencies.unshift("deps.rip")

# deps.rip.str:
##!/usr/bin/env rip install
#
## Syntax:
## repository [tag or commit to install]
#git://github.com/botanicus/media-path.git %{media_path}
#git://github.com/rack/rack.git %{rack}

FileTask.new("deps.rip", "deps.rip.str") do |task|
  task.config[:versions] = Hash.new
  task.description = "Regenerate deps.rip"
  task.define do
    data = File.read("deps.rip.str")
    dependencies = "%Q{#{data}}" % task.config[:versions]
    FileUtils.echo("deps.str") > dependencies
    sh "chmod +x deps.rip"
  end
end
