class RemoveIndexFromRequests < ActiveRecord::Migration[6.0]
  def change
    remove_index :requests, column: :user_id
  end
end
