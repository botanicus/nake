#!/usr/bin/env cucumber

Feature: Invoking tasks
  Scenario: without arguments
    When I run "./examples/invoking.rb foo"
    Then it should show "Arguments: []"
    And it should show "Options: {}"
    And it should suceed

  Scenario: with arguments
    When I run "./examples/invoking.rb foo bar a b --name=botanicus"
    Then it should show "Arguments: ["a", "b"]"
    And it should show "Options: {:name=>botanicus}"
    And it should suceed
