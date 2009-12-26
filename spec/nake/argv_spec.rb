# encoding: utf-8

require_relative "../spec_helper"
require "nake/argv"

describe Nake::ArgvParsingMixin do
  def parse(*args)
    args.extend(Nake::ArgvParsingMixin)
    args.extract!
  end

  describe "#parse!" do
    it "should returns Hash" do
      parse.should be_kind_of(Hash)
    end

    it "should parse --git-repository to {git_repository: true}" do
      options = parse("--git-repository")
      options[:git_repository].should be_true
    end

    it "should parse --no-github to {github: false}" do
      options = parse("--no-github")
      options[:github].should be_false
    end

    it "should parse --controller=posts to {controller: 'posts'}" do
      options = parse("--controller=posts")
      options[:controller].should eql("posts")
    end

    it "should parse --models=post,comment to {models: ['post', 'comment']}" do
      options = parse("--models=post,comment")
      options[:models].should eql(["post", "comment"])
    end

    it "should remove argument from ARGV if the argument was successfuly mapped to an option" do
      args = ["--user=botanicus"]
      args.extend(Nake::ArgvParsingMixin)
      args.extract!
      args.should be_empty
    end

    it "should not remove argument from ARGV if the argument wasn't mapped to an option" do
      args = ["one", "two", "three"]
      args.extend(Nake::ArgvParsingMixin)
      args.extract!
      args.length.should eql(3)
    end
  end
end
