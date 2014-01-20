class Chore < ActiveRecord::Base
  attr_accessible :child_id, :completed, :due_on, :task_id

  belongs_to :child 
  belongs_to :task

  validates_date :due_on 

  scope :by_task, joins(:task).order('tasks.name')
  scope :chronological, order('due_on')
  scope :pending, where('completed = ?', false)
  scope :done, where('completed = ?', true)
  scope :upcoming, where('due_on >= ?', Date.today)
  scope :past, where('due_on < ?', Date.today)

  def status
  	if completed == true 
  		return "Completed"
  	end
  	else 
  		return "Pending"
  	end 
end
