#!./bin/nake
# encoding: utf-8

task(:build) do
  sh "gem build nake.gemspec"
end

# ./tasks.rb spec/nake/argv_spec.rb spec/nake/task_spec.rb
task(:spec) do |*paths, options|
  paths.push("spec") if paths.empty?
  exec "spec #{paths.join(" ")}"
end
