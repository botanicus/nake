#!./bin/nake

begin
  require "recho"
rescue LoadError
  raise LoadError, "This task require recho gem!"
end

directory "www"

file "www/index.html", "www" do
  echo("<html>Hello World!</html>") > "www/index.html"
end
