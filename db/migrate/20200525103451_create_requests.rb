class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.belongs_to :user, index: { unique: true }, foreign_key: true
      t.string :search_string
      t.string :substring
      t.json :result_data
      t.boolean :result

      t.timestamps
    end
  end
end
