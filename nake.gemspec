#!/usr/bin/env gem build
# encoding: utf-8

# NOTE: we can't use require_relative because when we run gem build, it use eval for executing this file
#$:.unshift(File.join(File.dirname(__FILE__), "lib"))
#require "nake"
require "base64"

Gem::Specification.new do |s|
  s.name = "nake"
  s.version = "0.1"
  s.authors = ["Jakub Šťastný aka Botanicus"]
  s.homepage = "http://github.com/botanicus/nake"
  s.summary = "Nake is light-weight and highly flexible Rake replacement with much better arguments parsing"
  s.description = "" # TODO: long description
  s.email = Base64.decode64("c3Rhc3RueUAxMDFpZGVhcy5jeg==\n")
  s.has_rdoc = true

  # files
  s.files = `git ls-files`.split("\n")

  s.executables = Dir["bin/*"].map(&File.method(:basename))
  s.default_executable = "nake"
  s.require_paths = ["lib"]

  # dependencies
  s.add_dependency "term-ansicolor"

  begin
    require "changelog"
  rescue LoadError
    warn "You have to have changelog gem installed for post install message"
  else
    s.post_install_message = CHANGELOG.new.version_changes
  end

  # RubyForge
  s.rubyforge_project = "nake"
end
