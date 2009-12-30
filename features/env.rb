# encoding: utf-8

require "spec"
require "fileutils"

# just for ensuring the tests will pass on all machines
ENV["USER"] = "botanicus"

After do
  FileUtils.rm_rf "tmp"
end
