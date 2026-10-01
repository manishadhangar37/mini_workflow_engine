require "rails_helper"

RSpec.describe Workflow, type: :model do
  it "workflow is valid with required attributes" do
    workflow = Workflow.new(
      name: "test2",
      enabled: "true",
      defination_jason: "{}"
    )

    expect(workflow).to be_valid
  end

  it "workflow requires name" do
    workflow = Workflow.new(
      name: nil,
      enabled: "true",
      defination_jason: "{}"
    )

    expect(workflow).not_to be_valid
    expect(workflow.errors[:name]).to include("can't be blank")
  end

  it "workflow name must be unique" do
    Workflow.create!(
      name: "test3",
      enabled: "true",
      defination_jason: "{}"
    )

    workflow = Workflow.new(
      name: "welcome",
      enabled: "true",
      defination_jason: "{}"
    )

    expect(workflow).not_to be_valid
    expect(workflow.errors[:name]).to include("has already been taken")
  end

  it "workflow requires defination_jason" do
    workflow = Workflow.new(
      name: "welcome",
      enabled: "true",
      defination_jason: nil
    )

    expect(workflow).not_to be_valid
    expect(workflow.errors[:defination_jason]).to include("can't be blank")
  end

  it "workflow generates trigger path automatically" do
    workflow = Workflow.new(
      name: "Welcome Message",
      defination_jason: "{}"
    )

    expect(workflow.trigger_path).to be_nil

    workflow.valid?

    expect(workflow.trigger_path).not_to be_nil
    expect(workflow.trigger_path.length).to eq(32)
  end
end
