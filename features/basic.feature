#!/usr/bin/env cucumber

Feature: Task arguments
  Scenario: run the example
    When I run "./examples/basic.rb greet"
    Then it should succeed with "Hi botanicus!"
