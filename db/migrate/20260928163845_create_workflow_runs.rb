class CreateWorkflowRuns < ActiveRecord::Migration[8.1]
  def change
    create_table :workflow_runs do |t|
      t.references :workflow, null: false, foreign_key: true
      t.string :status
      t.jsonb :input_payload
      t.jsonb :output_context
      t.text :error_message
      t.string :started_at
      t.string :finished_at

      t.timestamps
    end
  end
end
