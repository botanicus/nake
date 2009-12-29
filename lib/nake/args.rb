# encoding: utf-8

require "nake/dsl"

argument("-H", "--help") do
  Kernel.abort "Use #{$0} -T for list of all available tasks or -i for interactive session"
end

argument("-T", "--tasks") do |pattern = nil|
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
  exit!
end

Nake.args["--verbose", "--no-verbose"] = lambda { |key, value| Nake.verbose = value }
Nake.args["--debug", "--no-debug"]     = lambda { |key, value| Nake.debug = value }
