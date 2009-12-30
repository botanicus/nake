#!/usr/bin/env cucumber

Feature: Running bin/nake
  Scenario: Running bin/nake without any arguments
    When I run "./bin/nake"
    Then it should fail with "You have to specify a task you want to run!"

  Scenario: Running bin/nake with a file, but without any arguments
    When I run "./bin/nake examples/task_arguments.rb"
    Then it should fail with "You have to specify a task you want to run!"

  Scenario: Running bin/nake with a task
    When I run "./bin/nake examples/task_arguments.rb greet"
    Then it should succeed with "Hi botanicus"

  Scenario: Running bin/nake with a task and arguments
    When I run "./bin/nake examples/task_arguments.rb greet Jakub"
    Then it should succeed with "Hi Jakub"

  Scenario: Running task file with shebang to nake with a task
    When I run "./examples/task_arguments.rb greet Jakub"
    Then it should succeed with "Hi Jakub"

  Scenario: Scenario: Running task file with shebang to nake with a task and arguments
    When I run "./examples/task_arguments.rb greet Jakub"
    Then it should succeed with "Hi Jakub"
