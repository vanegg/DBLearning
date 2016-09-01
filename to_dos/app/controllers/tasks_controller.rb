class TasksController
  def initialize(args)
    @view = TasksView.new
    @action = ARGV[0]
    action
  end

  def action
    case @action
      when 'add' then add
      when 'index' then index
      when 'delete' then delete
      when 'complete' then complete
      else return @view.error
    end
  end

  def index
    # TIP: Aquí debes de llamar al método del mismo nombre de @view
    tasks = Task.all
    @view.index(tasks)
  end

  def add    
    task = @view.create(1)    
    new_task = Task.new(name: task)
    new_task.save ? @view.create(2) : @view.error
  end

  def delete
    id_temp = @view.delete(1).to_i - 1
    tasks = Task.all
    task = Task.find(tasks[id_temp].id)
    task.destroy ? @view.delete(2) : @view.error
  end

  def complete
    id_temp = @view.update(1).to_i - 1
    tasks = Task.all
    task = Task.find(tasks[id_temp].id)
    value = task.complete ? false : true
    task.update(complete: value) ? @view.update(2) : @view.error
  end
  
end
