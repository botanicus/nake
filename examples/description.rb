desc :release, "Create a new release"
task(:release) do
  # ...
end

task = task(:release) do
  # ...
end
task.description = "Create a new release"

task(:release) do
  # ...
end
Task[:release].description = "Create a new release"

task = task(:release)
task.description = "Create a new release"
task.define do
  # ...
end

task(:release)
Task[:release].description = "Create a new release"
task(:release) do
  # ...
end

Task.new(:release) do |task|
  task.description = "Create a new release"
  task.define do
    # ...
  end
end
