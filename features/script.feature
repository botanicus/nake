#!/usr/bin/env cucumber

Feature: Using Nake API for custom scripts
  Scenario: running default tasks
    When I run "./examples/script.rb -T"
    Then it should succeed with "Available tasks"

  Scenario: running custom tasks
    When I run "./examples/script.rb greet:all"
    Then it should succeed with "Hi guys!"
