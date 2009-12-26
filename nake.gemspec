#!/usr/bin/env gem build
# encoding: utf-8

# NOTE: we can't use require_relative because when we run gem build, it use eval for executing this file
$:.unshift(File.join(File.dirname(__FILE__), "lib"))
require "nake"

Gem::Specification.new do |s|
  s.name = "nake"
  s.version = Nake::VERSION
  s.authors = ["Jakub Šťastný aka Botanicus"]
  s.homepage = "http://github.com/botanicus/nake"
  s.summary = "Nake is light-weight and highly flexible Rake replacement with much better arguments parsing"
  s.description = "" # TODO: long description
  s.cert_chain = nil
  s.email = ["knava.bestvinensis", "gmail.com"].join("@")
  s.has_rdoc = true

  # files
  s.files = Dir.glob("**/*")
  s.executables = ["nake"]
  s.default_executable = "nake"
  s.require_paths = ["lib"]

  # Ruby version
  s.required_ruby_version = ::Gem::Requirement.new("~> 1.9")

  # dependencies
  s.add_dependency "term-ansicolor"

  begin
    require "changelog"
  rescue LoadError
    warn "You have to have changelog gem installed for post install message"
  else
    changelog = CHANGELOG.new(File.join(File.dirname(__FILE__), "CHANGELOG"))
    s.post_install_message = "=== Changes in the last Nake ===\n- #{changelog.last_version_changes.join("\n- ")}"
  end

  # RubyForge
  s.rubyforge_project = "nake"
end
