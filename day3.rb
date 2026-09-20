tasks = [
  {
    id: 1,
    title: "Fix Login Bug",
    status: "pending",
    priority: "high"
  },
  {
    id: 2,
    title: "Build Dashboard",
    status: "completed",
    priority: "medium"
  },
  {
    id: 3,
    title: "Create REST API",
    status: "in_progress",
    priority: "high"
  }
]

def show_tasks(tasks)
  puts
  puts "===== TaskHub Tasks ====="

  tasks.each do |task|
    puts "#{task[:id]}. #{task[:title]}"
    puts "Status: #{task[:status]}"
    puts "Priority: #{task[:priority]}"
    puts "--------------------"
  end
end

def find_task(tasks, id)
  tasks.find do |task|
    task[:id] == id
  end
end

def filter_by_status(tasks, status)
  tasks.select do |task|
    task[:status] == status
  end
end

def create_task(tasks, title, status, priority)
  new_task = {
    id: tasks.length + 1,
    title: title,
    status: status,
    priority: priority
  }

  tasks << new_task
end

show_tasks(tasks)

puts
puts "===== Pending Tasks ====="

pending_tasks = filter_by_status(tasks, "pending")

pending_tasks.each do |task|
  puts task[:title]
end

puts
puts "===== Find Task ====="

task = find_task(tasks, 2)

if task
  puts "Found: #{task[:title]}"
else
  puts "Task not found."
end

puts
puts "===== Create Task ====="

create_task(
  tasks,
  "Write Unit Tests",
  "pending",
  "medium"
)

show_tasks(tasks)