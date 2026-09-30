require "test_helper"

class WorkflowTest < ActiveSupport::TestCase
  test "workflow is valid with required attributes" do
    workflow = Workflow.new(name: "welcome", enabled: "true", defination_jason: "{}")
    assert workflow.valid?
  end

  test "workflow is requires name" do
    workflow = Workflow.new(name: nil, enabled: "true", defination_jason: "{}")
    assert_not workflow.valid?
    assert_includes workflow.errors[:name], "can't be blank"
  end

  test "workflow is requires defination_jason " do
    workflow = Workflow.new(name: "welcome", enabled: "true", defination_jason: nil)
    assert_not workflow.valid?
    assert_includes workflow.errors[:defination_jason], "can't be blank"
  end

  test "workflow generates trigger path automatically" do
    workflow = Workflow.new(
      name: "Welcome Message",
      defination_jason: "{}"
    )

    assert_nil workflow.trigger_path

    workflow.valid?

    assert_not_nil workflow.trigger_path
    assert_equal 32, workflow.trigger_path.length
  end
end
