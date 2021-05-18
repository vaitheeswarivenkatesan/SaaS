require "active_record"

class Todo < ActiveRecord::Base
  # To check if due_date is overdue
  def overdue?
    due_date < Date.today
  end

  # To check if due_date is due_today
  def due_today?
    due_date == Date.today
  end

  # To check if due_date is due_later
  def due_later?
    due_date > Date.today
  end

  #This returns an array of overdue todos
  def self.overdue
    all.select { |todo| todo.overdue? }
  end
  #This returns an array of due_today todos
  def self.due_today
    all.select { |todo| todo.due_today? }
  end
  #This returns an array of due_later todos
  def self.due_later
    all.select { |todo| todo.due_later? }
  end
  #This prints todos from the database in the given format:
  def self.show_list
    puts "My Todo-list\n\n"

    puts "Overdue\n"
    todos = overdue
    puts to_displayable_list(todos)
    puts "\n\n"

    puts "Due Today\n"
    todos = due_today
    puts to_displayable_list(todos)
    puts "\n\n"

    puts "Due Later\n"
    todos = due_later
    puts to_displayable_list(todos)
    puts "\n\n"
  end
  # This
  def to_displayable_string
    display_id = format("%02d", "#{id}")
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_today? ? nil : due_date
    "#{display_id}. #{display_status} #{todo_text} #{display_date}"
  end

  #
  def self.add_task(todo)
    self.create!(todo_text: todo[:todo_text], due_date: Date.today + todo[:due_in_days],completed: false)
  end

  def self.mark_as_complete!(todo_id)
    todo = self.find(todo_id)
    if (!todo.completed)
      todo.completed = true
      todo.save
    else
      puts "Already marked completed"
    end
    return todo
  end

  def self.to_displayable_list(todos)
    todos.map { |todo| todo.to_displayable_string }
  end
end
