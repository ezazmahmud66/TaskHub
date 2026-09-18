puts "===== TaskHub ====="

print "Enter your role (admin/member): "
role = gets.chomp.downcase

print "Enter task title: "
task_title = gets.chomp

print "Enter task status (pending/in_progress/completed): "
status = gets.chomp.downcase

print "Enter priority (high/medium/low): "
priority = gets.chomp.downcase

puts
puts "===== Task Details ====="
puts "Task: #{task_title}"

case status
when "pending"
  puts "Status: Task has not started."
when "in_progress"
  puts "Status: Task is currently running."
when "completed"
  puts "Status: Task completed."
else
  puts "Status: Invalid"
end

case priority
when "high"
  puts "Priority: Urgent"
when "medium"
  puts "Priority: Normal"
when "low"
  puts "Priority: Low"
else
  puts "Priority: Invalid"
end

if role == "admin"
  puts "Permission: You can edit or delete this task."
elsif role == "member"
  puts "Permission: You can update your assigned task."
else
  puts "Permission: Unknown role."
end