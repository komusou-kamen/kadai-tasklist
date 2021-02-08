class RemoveUsersFromTasks < ActiveRecord::Migration[5.2]
  def change
    remove_reference :tasks, :users, foreign_key: true
  end
end
