#!./bin/nake

task = task(:greet3, :greet1, :greet2)
task.description = "Run greet1 & greet2"
