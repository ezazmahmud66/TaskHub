require 'json'

# ==========================================
# 1. Task Class (Data Structure)
# ==========================================
class Task
  attr_accessor :id, :title, :completed

  def initialize(id, title, completed = false)
    @id = id
    @title = title
    @completed = completed
  end

  # Ruby Object ke Hash-e convert korar method (JSON save korar jonno)
  def to_h
    {
      id: @id,
      title: @title,
      completed: @completed
    }
  end

  # Task status display korar jonno helper
  def status_text
    @completed ? "[X] Completed" : "[ ] Pending"
  end
end

# ==========================================
# 2. TaskManager Class (Business Logic & File I/O)
# ==========================================
class TaskManager
  FILE_NAME = "tasks.json"

  def initialize
    @tasks = load_tasks_from_file
  end

  # --- Add Task ---
  def add_task(title)
    if title.strip.empty?
      puts "\n❌ Error: Task title cannot be empty!"
      return
    end

    # Auto increment ID generate
    new_id = @tasks.empty? ? 1 : @tasks.last.id + 1
    new_task = Task.new(new_id, title)
    
    @tasks << new_task
    save_tasks_to_file
    puts "\n✅ Task '#{title}' successfully added! (ID: #{new_id})"
  end

  # --- List All Tasks ---
  def list_tasks
    if @tasks.empty?
      puts "\n📭 No tasks found! Add some tasks first."
      return
    end

    puts "\n=========================================="
    puts "            YOUR TASK LIST               "
    puts "=========================================="
    @tasks.each do |task|
      puts "ID: #{task.id} | #{task.status_text} | #{task.title}"
    end
    puts "=========================================="
  end

  # --- Mark Task as Completed ---
  def complete_task(id)
    task = @tasks.find { |t| t.id == id }

    if task
      task.completed = true
      save_tasks_to_file
      puts "\n🎉 Task ID #{id} marked as Completed!"
    else
      puts "\n❌ Error: Task with ID #{id} not found!"
    end
  end

  # --- Delete Task ---
  def delete_task(id)
    task = @tasks.find { |t| t.id == id }

    if task
      @tasks.delete(task)
      save_tasks_to_file
      puts "\n🗑️ Task ID #{id} deleted successfully!"
    else
      puts "\n❌ Error: Task with ID #{id} not found!"
    end
  end

  private

  # --- Load Tasks from JSON File ---
  def load_tasks_from_file
    return [] unless File.exist?(FILE_NAME)

    file_content = File.read(FILE_NAME)
    return [] if file_content.strip.empty?

    # JSON String to Ruby Array/Hash parse
    parsed_data = JSON.parse(file_content)

    # Hash theke Task Object-e convert kora
    parsed_data.map do |data|
      Task.new(data["id"], data["title"], data["completed"])
    end
  rescue JSON::ParserError
    []
  end

  # --- Save Tasks to JSON File ---
  def save_tasks_to_file
    File.open(FILE_NAME, "w") do |file|
      # Task Objects-er Array ke Hash-er Array বানিয়ে JSON convert kora
      hashes_array = @tasks.map(&:to_h)
      file.write(JSON.pretty_generate(hashes_array))
    end
  end
end

# ==========================================
# 3. User Interface (CLI Loop)
# ==========================================
def start_app
  manager = TaskManager.new

  loop do
    puts "\n"
    puts "=========================================="
    puts "             TASKHUB CLI APP              "
    puts "=========================================="
    puts "1. View All Tasks"
    puts "2. Add New Task"
    puts "3. Mark Task as Completed"
    puts "4. Delete Task"
    puts "5. Exit"
    puts "=========================================="
    print "Enter choice (1-5): "

    choice = gets.chomp.to_i

    case choice
    when 1
      manager.list_tasks
    when 2
      print "Enter Task Title: "
      title = gets.chomp
      manager.add_task(title)
    when 3
      print "Enter Task ID to Complete: "
      id = gets.chomp.to_i
      manager.complete_task(id)
    when 4
      print "Enter Task ID to Delete: "
      id = gets.chomp.to_i
      manager.delete_task(id)
    when 5
      puts "\n👋 Thank you for using TaskHub! Goodbye!"
      break
    else
      puts "\n❌ Invalid option! Please enter a number between 1 and 5."
    end
  end
end

# Start the application
start_app