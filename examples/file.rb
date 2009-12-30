#!/usr/bin/env ./bin/nake

# File tasks doesn't have any options or arguments,
# because if you have some setup which may generate
# each time different file, than the whole machinery
# for recognization if given task should run is useless.
# Of course you may want to use task for generating
# a file with arguments and options, but then just
# use a normal task helper or Task.new method.

directory "tmp"
directory "tmp/www"

file("tmp/restart.txt", "tmp") do |path|
  touch path
end

file("tmp/www/index.html", "tmp/www") do |path|
  File.open(path, "w") do |file|
    file.puts("<html>Hello World!</html>")
  end
end
