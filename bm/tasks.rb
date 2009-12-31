#!../bin/nake

task :simple do
  puts "Hello World!"
end

task "a:b:c:d:e:f:g:h:i:j:k:l:m:n:o:p:q:r:s:t:u:v:w:x:y:z" do
  # do nothing
end

directory "tmp/www"

file "tmp/www/index.html", "tmp/www" do |path|
  File.open(path, "w") do |file|
    file.puts("<html>Hello World!</html>")
  end
end

#rule ".o" => [".c"] do |task|
#  sh "gcc #{task.source} -c -o #{task.name}"
#end
