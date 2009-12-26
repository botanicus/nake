# encoding: utf-8

# ./tasks.rb spec/nake/argv_spec.rb spec/nake/task_spec.rb
task(:spec) do |*paths, options|
  paths.push("spec") if paths.empty?
  exec "spec #{paths.join(" ")}"
end

Task.new("spec:stubs") do |task|
  task.description = "Create stubs of all library files."
  task.define do
    Dir.glob("lib/**/*.rb").each do |file|
      specfile = file.sub(/^lib/, "spec").sub(/\.rb$/, '_spec.rb')
      unless File.exist?(specfile)
        %x[mkdir -p #{File.dirname(specfile)}]
        %x[touch #{specfile}]
        puts "Created #{specfile}"
      end
    end
    (Dir.glob("spec/rango/**/*.rb") + ["spec/rango_spec.rb"]).each do |file|
      libfile = file.sub(/spec/, "lib").sub(/_spec\.rb$/, '.rb')
      if !File.exist?(libfile) && File.zero?(file)
        %x[rm #{file}]
        puts "Removed empty file #{file}"
      elsif !File.exist?(libfile)
        puts "File exists just in spec, not in lib: #{file}"
      end
    end
  end
end
