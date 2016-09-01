class TasksView
	# Recuerda que la única responsabilidad de la vista es desplegar data al usuario

	def index(tasks)
    puts "Las tareas en la lista son:"
    puts "ID"
    tasks.each do |task|
      status = task.complete ? "X" : " "
    puts "#{task.id}. [#{status}] #{task.name}"
    end
	end

  def create(step)
    if step == 1
      puts "Indica la nueva tarea: " 
      STDIN.gets.chomp
    else
      puts "Tarea agregada!"
    end
  end

  def delete(step)
    if step == 1
      puts "Indica el ID de la tarea que deseas eliminar: "
      STDIN.gets.chomp
    else
      puts "Tarea eliminada"
    end
  end

  def update(step)
    if step == 1
      puts "Indica el ID de la tarea que deseas modificar: "
      STDIN.gets.chomp
    else
      puts "Tarea completada"
    end
  end

	def error
    puts "Acción incompleta"
	end
end
