#!./bin/nake

task(:ls) { sh "ls" }.description = "List available files"
