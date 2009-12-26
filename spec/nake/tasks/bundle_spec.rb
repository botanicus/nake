# encoding: utf-8

require_relative "../../spec_helper"
require "nake/tasks/bundle"

describe "Task bundle" do
  before(:each) do
    @task = Nake::Task[:bundle]
    @bundler = Object.new.define_singleton_method(:invoke) { |*args| args }
    @task.define_singleton_method(:bundler) { @bundler }
  end

  it "should invoke bundler with --cached by default" do
    @task.call.should include("--cached")
  end

  it "should invoke bundler without --cached if --no-cached argument is provided" do
    @task.call(cached: false).should_not include("--cached")
  end

  it "should not pass --no-cached argument to bundler" do
    @task.call(cached: false).should_not include("--no-cached")
  end

  it "should pass all other arguments to bundler" do
    @task.call("--only", "development").should eql(["--only", "development"])
  end
end
