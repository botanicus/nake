#!/usr/bin/env cucumber

Feature: Helpers
  Scenario: Using sh helper
    When I run "./examples/helpers.rb greet"
    Then it should succeed with "Hey from shell!"
