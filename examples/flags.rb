#!./bin/nake --verbose

# This example document how you can change different flags
# - specify these flags in shebang
# - use API directly
# - ./examples/flags --verbose
Nake.verbose = false

task(:setup) do
  puts "Setting environment ..."
end

task(:build, :setup) do
  puts "Building ..."
end
