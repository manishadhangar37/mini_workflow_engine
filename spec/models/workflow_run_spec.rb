require "rails_helper"

RSpec.describe WorkflowRun, type: :model do
  it "belongs to a workflow" do
    workflow = Workflow.create!(
      name: "test1",
      enabled: "true",
      defination_jason: "{}"
    )

    workflow_run = WorkflowRun.new(workflow: workflow)

    expect(workflow_run.workflow).to eq(workflow)
  end
end
