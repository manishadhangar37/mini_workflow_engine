class WorkflowRunsController < ApplicationController
    def index
        @workflow_run = WorkflowRun.all
    end

    def show
        @workflow_run = WorkflowRun.find(params[:id])
    end

    def create
        workflow = Workflow.find_by(trigger_path: params[:path])
        begin
            JSON.parse(workflow.defination_jason)
        rescue JSON::ParserError
            render json: { error: "Invalid JSON" }, status: :unprocessable_entity
            return
        end

        if workflow.enabled == "false"
            render json: { error: "Workflow is disabled" }, status: :forbidden
            return
        end
        workflow_run = workflow.workflow_runs.create!(input_payload: { type: params[:type], success: params[:success]  }, started_at: Time.current,)
        workrunner = WorkflowRunner.new(workflow, workflow_run)
        workrunner.call
    end
end
