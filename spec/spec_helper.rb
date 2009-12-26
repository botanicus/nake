# encoding: utf-8

begin
  require "spec"
rescue LoadError
  abort "You have to install rspec gem!"
end

require "stringio"

def STDOUT.capture(&block)
  before = self
  $stdout = StringIO.new
  block.call
  $stdout.rewind
  output = $stdout.read
  $stdout = before
  output
end
