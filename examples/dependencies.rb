#!/usr/bin/env ./bin/nake

task(:greet1)
task(:greet2)

task = task(:greet3, :greet1, :greet2)
task.description = "Run greet1 & greet2"
