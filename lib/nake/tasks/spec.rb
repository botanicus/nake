# encoding: utf-8

# ./tasks.rb spec/nake/argv_spec.rb spec/nake/task_spec.rb
task(:spec) do |*paths, options|
  paths.push("spec") if paths.empty?
  sh "spec", *paths
end

Task.new("spec:stubs") do |task|
  task.description = "Create stubs of all library files."
  task.define do
    Dir.glob("lib/**/*.rb").each do |file|
      specfile = file.sub(/^lib/, "spec").sub(/\.rb$/, '_spec.rb')
      unless File.exist?(specfile)
        sh "mkdir -p #{File.dirname(specfile)}"
        sh "touch #{specfile}"
      end
    end
  end
end
