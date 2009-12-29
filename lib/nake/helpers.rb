# encoding: utf-8

require "fileutils"
require "nake/colors"

module Nake
  module TaskHelpers
    include FileUtils
    def run(*parts)
      puts parts.join(" ").cyan
      system(*parts)
    end

    # return true if process suceeded, false otherwise
    # sh "ls -a"
    # sh "ls", "-a"
    def sh(*parts)
      puts "#{"$".magenta} #{parts.join(" ").cyan}"
      system("sh", "-c", *parts)
    end

    # zsh "ls .*(.)"
    def zsh(*parts)
      puts "#{"%".magenta} #{parts.join(" ").cyan}"
      system("zsh", "-c", *parts)
    end
  end

  module PrintHelpers
    def info(message)
      puts "~ #{message}".cyan if Nake.verbose
    end

    def note(message)
      puts "~ #{message}".green if Nake.verbose
    end

    def warn(message)
      Kernel.warn("~ #{message.yellow}") if Nake.debug
    end

    def debug(message)
      STDERR.puts("~ #{message.yellow}") if Nake.debug
    end

    def error(message)
      STDERR.puts "~ #{message}".red
    end

    def abort(message)
      Kernel.abort "[#{"ERROR".red}] #{message}"
    end

    def print_exception_and_abort(exception)
      abort exception.message
    end

    def print_exception_with_backtrace_and_abort(exception)
      abort [exception.message, exception.backtrace.join("\n- ")].join("\n")
    end
  end
end

Object.send(:include, Nake::TaskHelpers)
Object.send(:include, Nake::PrintHelpers)
