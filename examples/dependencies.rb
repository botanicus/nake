#!/usr/bin/env ./bin/nake

# You can do the same by adding Task[name].call in the define block, but please,
# don't use this approach. Dependencies are readable and if someone wants to,
# he can simply remove a dependency from the dependency array.
task(:greet1)
task(:greet2)

task = task(:greet3, :greet1, :greet2)
task.description = "Run greet1 & greet2"
