#!/usr/bin/env ruby

$VERBOSE = nil # shut up

require "rbench"

rake = `which rake`.chomp
nake = "./bin/nake"

abort "You have to install Rake!" if rake.empty?
puts "Using nake from #{nake} and rake from #{rake}\n\n"

def run(command)
  system("#{command} &> /dev/null") || abort("Problem during running #{command}")
end

# Make sure you are running both Rake and Nake on the same Ruby version!
RBench.run(10) do
  column :rake
  column :nake

  report "list tasks" do
    rake { run "#{rake} -T" }
    nake { run "#{nake} -T" }
  end

  report "simple task" do
    rake { run "#{rake} simple" }
    nake { run "#{nake} simple" }
  end

  report "namespaced task" do
    rake { run "#{rake} a:b:c:d:e:f:g:h:i:j:k:l:m:n:o:p:q:r:s:t:u:v:w:x:y:z" }
    nake { run "#{nake} a:b:c:d:e:f:g:h:i:j:k:l:m:n:o:p:q:r:s:t:u:v:w:x:y:z" }
  end

  #report "task with arguments" do
  #  rake { run "#{rake} arguments" }
  #  nake { run "#{nake} arguments" }
  #end
  #
  #report "task with dependencies" do
  #  rake { run "#{rake} dependencies" }
  #  nake { run "#{nake} dependencies" }
  #end

  report "file task" do
    rake { run "#{rake} tmp/www/index.html" }
    nake { run "#{nake} tmp/www/index.html" }
  end

  #report "rule" do
  #  rake { run "#{rake} tmp/test.o" }
  #  nake { run "#{nake} tmp/test.o" }
  #end
end
