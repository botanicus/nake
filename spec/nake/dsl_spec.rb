# encoding: utf-8

require_relative "../spec_helper"
require "nake/dsl"

describe "Object#task" do
  before(:each) do
    Nake::Task.tasks.clear
  end

  it "should take name as a first argument" do
    task(:name).name.should eql(:name)
  end

  it "should optinally take other arguments as a dependencies" do
    task(:release, :build, :tag).dependencies.should eql([:build, :tag])
  end

  it "should optinally take a block as a task definition" do
    task = task(:release) { "released!" }
    task.should have(1).blocks
  end

  it "should be able to add a dependencies to the task definition" do
    task(:release, :build)
    task(:release, :tag)
    task(:release).dependencies.should eql([:build, :tag])
  end

  it "should be able to add a block to the task definition" do
    task = task(:release) { "first block" }
    task(:release) { "second block" }
    -> { task(:release) { "released!" } }.should change { task.blocks.length }.by(1)
  end
end
