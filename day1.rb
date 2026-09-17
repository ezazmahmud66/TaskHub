print "Enter your name: "
name = gets.chomp

print "Enter project name: "
project_name = gets.chomp

print "Enter total tasks: "
total_tasks = gets.chomp.to_i

print "Enter completed tasks: "
completed_tasks = gets.chomp.to_i

pending_tasks = total_tasks - completed_tasks

puts
puts "===== TaskHub Summary ====="
puts "User: #{name}"
puts "Project: #{project_name}"
puts "Total Tasks: #{total_tasks}"
puts "Completed: #{completed_tasks}"
puts "Pending: #{pending_tasks}"