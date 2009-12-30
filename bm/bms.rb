#!/usr/bin/env ruby

$VERBOSE = nil # shut up

require "rbench"

rake = `which rake`.chomp
nake = "./bin/nake"

abort "You have to install Rake!" if rake.empty?
puts "Using nake from #{nake} and rake from #{rake}\n\n"

# Make sure you are running both Rake and Nake on the same Ruby version!
RBench.run(10) do
  column :rake
  column :nake

  report "list tasks" do
    rake { system("#{rake} -T &> /dev/null") || abort("Problem during running #{rake} -T") }
    nake { system("#{nake} -T &> /dev/null") || abort("Problem during running #{nake} -T") }
  end
end
