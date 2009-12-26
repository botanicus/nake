#!./bin/nake

begin
  require "recho"
rescue LoadError
  raise LoadError, "This task require recho gem!"
end

directory "tmp"
directory "tmp/www"

file("tmp/restart.txt", "tmp") do |path|
  touch path
end

file "tmp/www/index.html", "tmp/www" do |path|
  echo("<html>Hello World!</html>") > path
end
