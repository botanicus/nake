#!/usr/bin/env cucumber

Feature: Task arguments
  Scenario: explicit arguments
    When I run "./examples/task_arguments.rb greet jakub"
    Then it should succeed with "Hi jakub!"

  Scenario: default arguments
    When I run "./examples/task_arguments.rb greet"
    Then it should succeed with "Hi botanicus!"
