class User
  attr_accessor :name, :email

  def initialize(name, email)
    @name = name
    @email = email
  end

  def permissions
    "Basic access"
  end
end

class Admin < User
  def permissions
    "Manage users, projects and tasks"
  end
end

class Member < User
  def permissions
    "View projects and update assigned tasks"
  end
end


class Task
  attr_accessor :title, :status, :priority

  VALID_STATUSES = [
    "pending",
    "in_progress",
    "completed"
  ]

  def initialize(title, priority)
    @title = title
    @priority = priority
    @status = "pending"
  end

  def update_status(new_status)
    if VALID_STATUSES.include?(new_status)
      @status = new_status
      true
    else
      false
    end
  end

  def completed?
    @status == "completed"
  end

  def show_details
    puts "Task: #{@title}"
    puts "Status: #{@status}"
    puts "Priority: #{@priority}"
  end
end


class Project
  attr_accessor :name, :tasks

  def initialize(name)
    @name = name
    @tasks = []
  end

  def add_task(task)
    @tasks << task
  end

  def show_tasks
    puts
    puts "===== #{@name} ====="

    @tasks.each_with_index do |task, index|
      puts "#{index + 1}. #{task.title}"
      puts "   Status: #{task.status}"
      puts "   Priority: #{task.priority}"
    end
  end

  def completed_tasks
    @tasks.select do |task|
      task.completed?
    end
  end
end


admin = Admin.new(
  "Rahim",
  "rahim@taskhub.com"
)

member = Member.new(
  "Karim",
  "karim@taskhub.com"
)

project = Project.new("TaskHub Development")

task1 = Task.new(
  "Fix Login Bug",
  "high"
)

task2 = Task.new(
  "Build Dashboard",
  "medium"
)

task3 = Task.new(
  "Create REST API",
  "high"
)

project.add_task(task1)
project.add_task(task2)
project.add_task(task3)

task1.update_status("completed")
task2.update_status("in_progress")

puts "Admin: #{admin.name}"
puts "Permission: #{admin.permissions}"

puts

puts "Member: #{member.name}"
puts "Permission: #{member.permissions}"

project.show_tasks

puts
puts "Completed Tasks:"

project.completed_tasks.each do |task|
  puts task.title
end