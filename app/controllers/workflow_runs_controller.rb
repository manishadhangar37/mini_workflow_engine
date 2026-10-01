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
            return render json: { error: "Invalid JSON" }, status: :unprocessable_entity

        end

        if workflow.enabled == "false"
            return render json: { error: "Workflow is disabled" }, status: :forbidden

        end
        workflow_run = workflow.workflow_runs.create!(input_payload: { type: params[:type], success: params[:success] == "true"  }, started_at: Time.current,)
        workrunner = WorkflowRunner.new(workflow, workflow_run)
           ans = workrunner.call

        if ans
            render json: { message: "Workflow executed successfully" }, status: :ok
        else
            render json: { message: "workflow does not match" }
        end
    end
end
