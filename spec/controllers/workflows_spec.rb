require 'rails_helper'

RSpec.describe WorkflowsController, type: :controller do
  describe "Get #index" do
    it "get all workflow run" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end
  describe "Get #show" do
    it "get one workflow" do
      workflow = Workflow.create(name: "show test", enabled: "true", defination_jason: '{"steps":[]}')
      get :show, params: { id: workflow.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH #update" do
  it "updates the workflow" do
    workflow = Workflow.create!(
      name: "Old Workflow",
      enabled: "true",
      defination_jason: "{}"
    )

    patch :update, params: { id: workflow.id, workflow: { name: "Updated Workflow" } }

    expect(workflow.reload.name).to eq("Updated Workflow")
    expect(response).to redirect_to(workflow_path(workflow))
  end
end
  describe "Get #destroy" do
    it "delete workflow" do
      workflow = Workflow.create(name: "delete test", enabled: "true", defination_jason: '{"steps":[]}')
      expect { delete :destroy, params: { id: workflow.id }
     }.to change(Workflow, :count).by(-1)

      expect(response).to redirect_to(workflows_path)
    end
  end
end
