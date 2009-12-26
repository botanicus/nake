# encoding: utf-8

require_relative "../spec_helper"
require "nake/task"

describe Nake::Task do
  before(:each) do
    Nake::Task.tasks.clear
  end

  describe "[]" do
    it "should find task with given name if the name is a symbol"
    it "should find task with given name if the name is a string"
    it "should find task with given alias if the alias is a symbol"
    it "should find task with given alias if the alias is a string"
  end

  describe "[]=" do
    it "should add the task into the Task.tasks hash with stringified key"
  end

  describe ".tasks" do
  end

  describe ".new" do
    it "should returns already existing task object if this object exists" do
      task = Task.new(:release)
      Task.new(:release).object_id.should eql(task.object_id)
    end
  end

  it "should take name as a first argument" do
    Task.new("name").name.should eql(:name)
  end

  it "should take name as a first argument" do
    Task.new(:name).name.should eql(:name)
  end

  describe "#define" do
    it "should puts block into the task.blocks collection" do
      task = Task.new(:name)
      -> { task.define { "a block" } }.should change { task.blocks.length }.by(1)
    end
  end

  describe "#hidden?" do
    it "should not be hidden by default" do
      task = Task.new(:name)
      task.should_not be_hidden
    end

    it "should be true if the task is hidden" do
      Task.new(:name).tap do |task|
        task.hidden = true
        task.should be_hidden
      end
    end

    it "should be false if the task isn't hidden" do
      Task.new(:name).tap do |task|
        task.hidden = false
        task.should_not be_hidden
      end
    end
  end

  describe "#call" do
    it "should call all dependencies"
    it "should call all blocks of the given task"
  end
end
