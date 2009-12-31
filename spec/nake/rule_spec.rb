# encoding: utf-8

require_relative "../spec_helper"
require "nake/rule"

describe Nake::Rule do
  before(:each) do
    Nake::Rule.rules.clear
  end

  describe "[]" do
    it "should find rule with given name if the name is a symbol"
    it "should find rule with given name if the name is a string"
    it "should find rule with given alias if the alias is a symbol"
    it "should find rule with given alias if the alias is a string"
  end

  describe "[]=" do
    it "should add the rule into the Nake::Rule.rules hash with stringified key"
  end

  describe ".rules" do
  end

  describe ".new" do
    it "should returns already existing rule object if this object exists" do
      rule = Nake::Rule.new(:release)
      Nake::Rule.new(:release).object_id.should eql(rule.object_id)
    end
  end

  it "should take name as a first argument" do
    Nake::Rule.new("name").name.should eql(:name)
  end

  it "should take name as a first argument" do
    Nake::Rule.new(:name).name.should eql(:name)
  end

  describe "#define" do
    it "should puts block into the rule.blocks collection" do
      rule = Nake::Rule.new(:name)
      -> { rule.define { "a block" } }.should change { rule.blocks.length }.by(1)
    end
  end

  describe "#hidden?" do
    it "should not be hidden by default" do
      rule = Nake::Rule.new(:name)
      rule.should_not be_hidden
    end

    it "should be true if the rule is hidden" do
      Nake::Rule.new(:name).tap do |rule|
        rule.hidden = true
        rule.should be_hidden
      end
    end

    it "should be false if the rule isn't hidden" do
      Nake::Rule.new(:name).tap do |rule|
        rule.hidden = false
        rule.should_not be_hidden
      end
    end
  end

  describe "#call" do
    it "should call all dependencies"
    it "should call all blocks of the given rule"
  end
end
