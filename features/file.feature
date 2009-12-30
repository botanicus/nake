#!/usr/bin/env cucumber

Feature: File tasks
  Scenario: running -T
    When I run "./examples/file.rb -T"
    Then it should not show "tmp/www"
    And it should show "tmp/restart.txt"
  
  Scenario: using directory helper
    When I run "./examples/file.rb tmp/www"
    Then it should create "tmp/www"
    And it should succeed

  Scenario: using file helper
    When I run "./examples/file.rb tmp/restart.txt"
    Then it should create "tmp/restart.txt"
    And it should succeed

  Scenario: using file helper when the target file already exist
    Given this is pending

  Scenario: using file helper when the target file already exist but is older than its dependencies
    Given this is pending
