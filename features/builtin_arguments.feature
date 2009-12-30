#!/usr/bin/env cucumber

Feature: Task arguments
  Scenario: running -H or --help
    When I run "./examples/basic.rb greet"
    Then it should succeed with "Hi botanicus!"

  Scenario: running -T or --tasks
    When I run "./examples/basic.rb greet"
    Then it should succeed with "Hi botanicus!"

  Scenario: running -i or --interactive
    When I run "./examples/basic.rb greet"
    Then it should succeed with "Hi botanicus!"
