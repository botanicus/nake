# encoding: utf-8

# I know, Rake is piece of shift, unfortunately RunCodeRun.com requires it.
# http://support.runcoderun.com/faqs/builds/how-do-i-run-rake-with-trace-enabled
Rake.application.options.trace = true

# default task for RunCodeRun.com
task(:default) { exec "spec spec && cucumber features" }
