# encoding: utf-8

require "nake/dsl"

argument("-H", "--help") do |task_name = nil|
  if task_name
    task = Task[task_name]
    if task
      p task # TODO
    else
      abort "Task #{task_name} doesn't exist"
    end
  else
    Kernel.abort "Use #{$0} -T for list of all available tasks or -i for interactive session"
  end
end

argument("-T", "--tasks") do |pattern = nil|
  Task.boot

  tasks, options = Task.tasks.select { |name, task| not task.hidden? }.sort.partition { |key, value| not key.match(/^-/) }
  arguments = Nake.args.sort

  puts "\n#{"===".yellow} #{"Available tasks".magenta} #{"===".yellow}"
  if tasks.empty?
    puts "No tasks defined"
  else
    tasks.each do |name, task|
      puts "#{name.green} #{task.dependencies.join(", ")} # #{task.description || "no description yet"}"
    end
  end

  puts "\n#{"===".yellow} #{"Available arguments".magenta} #{"===".yellow}"
  if arguments.empty?
    puts "No arguments defined"
  else
    arguments.each do |names, proc|
      puts "#{names.join(" or ").green}" # TODO: description
    end
  end
  exit
end

argument("-i", "--interactive") do |task = nil|
  Task.boot
  ARGV.clear # otherwise IRB will parse it

  require "irb"
  begin
    require "irb/readline"
  rescue LoadError
    warn "Code completion via readline isn't available"
  end

  if task
    Task[task].tap { |task| task.call(*args, options) }
  end

  IRB.start
  exit! # TODO: can we do it without exit? The usecase is ./tasks.rb -i mytask, so we can set env and then run the task
end

Nake.args["--verbose",  "--no-verbose"]  = lambda { |key, value| Nake.verbose = value }
Nake.args["--debug",    "--no-debug"]    = lambda { |key, value| Nake.debug = value }
Nake.args["--coloring", "--no-coloring"] = lambda { |key, value| Nake.coloring = value }
