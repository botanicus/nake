# encoding: utf-8

require "open3"

# http://redmine.ruby-lang.org/issues/show/1287
When /^I run "([^\"]*)"$/ do |command|
  _, @stdout, @stderr, thread = Open3.popen3(command)
  @status = thread.value.exitstatus
end

Then /^it should show "([^\"]*)"$/ do |pattern|
  @stdout.read.should_not match(pattern)
end

Then /^it should not show "([^\"]*)"$/ do |pattern|
  @stdout.read.should_not match(pattern)
end

Then /^it should succeed$/ do
  @status.should eql(0)
end

Then /^it should suceed with "([^\"]*)"$/ do |pattern|
  @stdout.read.should match(pattern)
  @status.should eql(0)
end

Then /^it should fail with status "(\d+)"$/ do |status = 0|
  @status.should eql(status.to_i)
end

Then /^it should fail with "([^\"]*)"$/ do |pattern|
  @stderr.read.should match(pattern)
  @status.should_not eql(0)
end

Then /^it should create "([^\"]*)"$/ do |path|
  File.exist?(path).should be_true
end
