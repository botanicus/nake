require "nake"
require "nake/args"
require "nake/helpers"

module Nake
  def self.run
    # parse arguments
    begin
      Nake.parse
    rescue Exception => exception
      puts "~ Arguments parsed into #{Nake.parse.inspect.green}"
      puts "Exception occured during parsing arguments"
      print_exception_with_backtrace_and_abort(exception)
    else
      if Nake.parse[:nake] && Nake.parse[:nake].include?("--debug") # Nake.debug isn't initialized yet
        puts "~ Arguments parsed into #{Nake.parse.inspect.green}"
      end
    end

    # load task file
    if Nake.parse[:file]
      begin
        load Nake.parse[:file]
      rescue Exception => exception
        print_exception_with_backtrace_and_abort(exception)
      end
    elsif File.exist?("tasks.rb")
      # default value, useful when running nake on systems without
      # shebang support, so you are using nake -T instead of ./tasks.rb -T
      Nake.parse[:file] = "tasks.rb"
    else
      abort "You have to specify a file with tasks"
    end

    # run arguments
    # yes, arguments has to run after the task file is loaded
    begin
      original_args = Nake.parse.dup
      Nake.run_args
    rescue SystemExit => exception
      exit exception.status
    rescue Exception => exception
      puts "~ Arguments parsed into #{Nake.parse.inspect.green}"
      puts "Exception occured setting nake flags"
      print_exception_with_backtrace_and_abort(exception)
    else
      if Nake.debug && Nake.parse != original_args
        puts "~ Arguments changed into #{Nake.parse.inspect.green}"
      end
    end

    # run tasks
    begin
      Nake.run_task
    rescue TaskNotFound => exception
      abort exception.message
    rescue SystemExit => exception
      exit exception.status
    rescue Exception => exception
      print_exception_with_backtrace_and_abort(exception)
    end

    # exit with exit status of the last command
    exit $? ? $?.exitstatus.to_i : 0
  end
end
