class CreateWorkflows < ActiveRecord::Migration[8.1]
  def change
    create_table :workflows do |t|
      t.string :name
      t.string :enabled
      t.string :trigger_path
      t.jsonb :defination_jason

      t.timestamps
    end
  end
end
