# encoding: utf-8

require_relative "../spec_helper"
require "nake/template"

describe Nake::Template do
  describe ".new" do
    it "should take one argument with path to the file" do
      -> { Nake::Template.new("spec/stubs/database.yml.tt") }.should_not raise_error
    end
  end

  describe "#render" do
    before(:each) do
      @template = Nake::Template.new("spec/stubs/database.yml.tt")
    end

    it "should generate a string" do
      output = @template.render(adapter: "sqlite3", name: "blog")
      output.should match("database: blog_development")
      output.should match("database: blog_test")
    end
  end
end

describe "Nake::TaskHelpers#template" do
  include Nake::TaskHelpers
  before(:each) do
    template "spec/stubs/database.yml.tt", "spec/stubs/database.yml", adapter: "sqlite3", name: "blog"
  end

  after(:each) do
    FileUtils.rm_rf "spec/stubs/database.yml"
  end

  it "should create a new file" do
    File.exist?("spec/stubs/database.yml").should be_true
  end

  it "should be filled with the data from the template" do
    content = File.read("spec/stubs/database.yml")
    content.should match("database: blog_development")
    content.should match("database: blog_test")
  end
end
