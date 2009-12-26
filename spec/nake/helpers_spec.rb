# encoding: utf-8

require_relative "../spec_helper"
require "nake/helpers"

describe Nake::TaskHelpers do
  include Nake::TaskHelpers
  describe "#sh" do
    it "should be able to execute external commands"
    it "should show which command runs"
    it "should show STDOUT of the command"
    it "should show STDERR of the command"
  end
end
