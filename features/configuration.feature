#!/usr/bin/env cucumber

Feature: Task configuration
  Scenario: explicit arguments
    Given this is pending
    When I run "./examples/configuration.rb"

  Scenario: default arguments
    Given this is pending
    When I run "./examples/configuration.rb"
