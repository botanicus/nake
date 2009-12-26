# encoding: utf-8

require "fileutils"

module Nake
  module TaskHelpers
    include FileUtils
    alias_method :run, :`

    # return true if process suceeded, false otherwise
    # sh "ls -a"
    # sh "ls", "-a"
    def sh(*parts)
      puts "#{"$".magenta} #{parts.join(" ").cyan}"
      run "#{parts.shift} #{parts.join(" ")}"
      $?.success?
    end
  end
end

Object.send(:include, Nake::TaskHelpers)
