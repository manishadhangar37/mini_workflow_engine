require "test_helper"

class WorkflowRunTest < ActiveSupport::TestCase
  test "should belong to workflow" do
    workflow = Workflow.create!(
      name: "Test Workflow",
      enabled: true,
      trigger_path: "test123",
      defination_jason: '{"steps":[]}'
    )

    workflow_run = WorkflowRun.new(workflow: workflow)

    assert workflow_run.valid?
    assert_equal workflow, workflow_run.workflow
  end
end
