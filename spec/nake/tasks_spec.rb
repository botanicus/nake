# encoding: utf-8

require_relative "../spec_helper"

load "nake/tasks.rb"
@result = STDOUT.capture { Task["-T"].call }

describe "Default tasks" do
  describe "-H" do
    before(:each) do
      load "nake/tasks.rb"
    end

    it "should be available as a -H or --help" do
      Task["-H"].should eql(Task["--help"])
    end

    it "should print a message about using -T and exit" do
      -> { Task["-H"].call }.should raise_error(SystemExit, /-T/)
    end
  end

  describe "-T" do
    before(:each) do
      load "nake/tasks.rb"
      task(:release, :build, :tag)
      @result = STDOUT.capture { Task["-T"].call }
    end

    it "should list all available tasks" do
      @result.should match("release")
    end

    it "should show description if there is any"

    it "should list dependencies if some are available"

    it "should list aliases"

    it "should not show hidden tasks" do
      @result.should_not match("-H")
    end
  end

  describe "-i" do
    # TODO
  end
end
