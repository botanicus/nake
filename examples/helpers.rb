#!/usr/bin/env ./bin/nake

task(:greet) { sh "echo Hey from shell!" }.description = "Greeting from shell"
