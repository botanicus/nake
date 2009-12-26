# encoding: utf-8

require "fileutils"
require "open3"

module Nake
  module TaskHelpers
    include FileUtils
    def sh(command)
      puts "#{"$".magenta} #{command.cyan}"
      Open3.popen3("sh", "-c", command) do |stdin, stdout, stderr|
        puts stdout.readlines.map { |line| "  #{line}" }
        puts stderr.readlines.map { |line| "  #{line.red}" }
      end
    end
  end
end

Object.send(:include, Nake::TaskHelpers)
