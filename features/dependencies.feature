#!/usr/bin/env cucumber

Feature: Task dependencies
  # it should show dependencies as well
  Scenario: inspecting with -T
    Given this is pending

  Scenario: Invoking task with dependencies which doesn't run yet
    When I run "./examples/dependencies.rb greet3"
    Then it should show "~ Invoking task greet1"
    And it should show "~ Invoking task greet2"
    And it should show "~ Invoking task greet3"
    And it should succeed

  Scenario: Invoking task with dependencies which already run
    Given this is pending
