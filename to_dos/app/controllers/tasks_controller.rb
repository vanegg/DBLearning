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
    id = @view.delete(1)
    task = Task.find_by(id: id)
    task.destroy ? @view.delete(2) : @view.error
  end

  def complete
    id = @view.update(1)
    task = Task.find_by(id: id)
    value = task.complete ? false : true
    task.update(complete: value) ? @view.update(2) : @view.error
  end
end
