require "rails_helper"

RSpec.describe WorkflowRunsController, type: :controller do
  describe "GET #index" do
    it "gets all workflow runs" do
      get :index

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #show" do
    it "gets a workflow run" do
      workflow = Workflow.create!(
        name: "Show Test",
        enabled: "true",
        defination_jason: '{"steps":[]}'
      )

      workflow_run = workflow.workflow_runs.create!(
        input_payload: {},
        started_at: Time.current
      )

      get :show, params: { id: workflow_run.id }

      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    it "creates a workflow run" do
      workflow = Workflow.create!(
        name: "Create Test Workflow",
        enabled: "true",
        defination_jason: '{"steps":[]}'
      )

      post :create, params: {
        path: workflow.trigger_path,
        type: "test4",
        success: "false"
      }

      expect(response).to have_http_status(:ok)
    end
  end
end
