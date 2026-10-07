class WorkflowRunsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :workflow_not_found
  def index
    @workflow_run = WorkflowRun.all
  end

  def show
      @workflow_run = WorkflowRun.find(params[:id])
  end

  def create
    workflow = Workflow.find_by(trigger_path: params[:path])
		unless workflow 
			return render json: {error: "workflow not found"}
		end
    begin
      JSON.parse(workflow.defination_jason)
      rescue JSON::ParserError
				return render json: { error: "Invalid JSON" }, status: :unprocessable_entity
		end
		if workflow.enabled == "false"
			return render json: { error: "Workflow is disabled" }, status: :forbidden
    end
    input_data = JSON.parse(params[:input_payload])
    
    workflow_run = workflow.workflow_runs.create!(input_payload: input_data, started_at: Time.current,)
    workrunner = WorkflowRunner.new(workflow, workflow_run)
    output = workrunner.call
    
    if output == 200
      
			render json: { message: "Workflow executed successfully" }, status: :ok
		else
      render json: { message: "workflow does not match" }
    end
  end

	def record_not_found
		render json: {error: "Record not found"}
	end
end
