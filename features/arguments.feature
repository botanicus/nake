#!/usr/bin/env cucumber

Feature: Arguments
  Scenario: Simple argument
    When I run "./examples/arguments.rb --report greet"
    Then it should show "Hey mate!"
    And it should succeed with "Running task greet took [\d.]+ seconds"

  Scenario: Argument taking options
    When I run "./examples/arguments.rb --debug greet"
    Then it should show "Setting debug to true"
    And it should suceed with "Hey mate!"

  Scenario: Argument taking options
    When I run "./examples/arguments.rb --no-debug greet"
    Then it should show "Setting debug to false"
    And it should suceed with "Hey mate!"

  Scenario: Arguments should be able to influence task execution
    When I run "./examples/arguments.rb --tasks greet"
    Then it should not show "Hey mate!"
    And it should suceed with "Available tasks: tasks, greet, wait"
