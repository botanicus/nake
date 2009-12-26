# encoding: utf-8

require "nake/dsl"

task(["-H", "--help"]) do
  abort "\nUse #{$0} -T for list of all available tasks or -i for interactive session"
end

task(["-T", "--tasks"]) do |pattern, options = Hash.new|
  tasks, options = Task.tasks.select { |name, task| not task.hidden? }.sort.partition { |key, value| not key.match(/^-/) }

  puts "\n#{"===".yellow} #{"Available tasks".magenta} #{"===".yellow}"
  if tasks.empty?
    puts "No tasks defined"
  else
    tasks.each do |name, task|
      puts "#{name.green} #{task.dependencies.join(", ")} # #{task.description || "no description yet"}"
    end
  end

  puts "\n#{"===".yellow} #{"Available options".magenta} #{"===".yellow}"
  if options.empty?
    puts "No options defined"
  else
    options.each do |name, task|
      puts "#{name.green} #{task.dependencies.join(", ")} # #{task.description || "no description yet"}"
    end
  end
end

# TODO: this doesn't work so far
task(["-i", "--interactive"]) do |*args, options|
  require "irb"
  begin
    require "irb/readline"
  rescue LoadError
    warn "Code completion via readline isn't available"
  end

  unless args.empty?
    task = Task[args.shift]
    task.call(*args, options)
  end

  IRB.start
end

Task["-T"].hidden = true
Task["-H"].hidden = true
