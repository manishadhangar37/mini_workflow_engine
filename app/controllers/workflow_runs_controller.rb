class WorkflowRunsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :workflow_not_found
  rescue_from URI::InvalidURIError, with: :handle_bad_uri

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
    unless workflow.enabled
      return render json: { error: "Workflow is disabled" }, status: :forbidden
    end

    input_data = JSON.parse(params[:input_payload])
    @workflow_run = workflow.workflow_runs.create!(input_payload: input_data, status: :failed, output_payload: { message: "not executed" }, started_at: Time.current,)
    output = WorkflowRunner.new(workflow, @workflow_run).call

    unless output
      return render json: { message: "workflow does not match" }
    end

    if output == "200"
      @workflow_run.update(status: :success, output_payload: { message: "workflow executed successfully" }, finished_at: Time.current)
      render json: { message: "Workflow executed successfully" }
    elsif output == "404"
      @workflow_run.update(status: :failed, error_message: "request failed")

      render json: { message: "workflow does not executed due to url not found" }
    else
        render json: { message: "workflow doen not executed with code  #{output}" }
    end
  end

  def destroy
    workflow_run = WorkflowRun.find(params[:id])
    if workflow_run.destroy
       redirect_to workflow_runs_path
    else
        render json: "workflow cant deleted"
    end
     
  end
  private
  def record_not_found
    @workflow_run.update(status: :failed, error_message: { message: "record not found" })
    render json: { error: "Record not found" }, status: :not_found
  end

  def handle_bad_uri
    @workflow_run.update(status: :failed, error_message: { error: "bad uri" })
    render json: { error: "check your slack URL, URL is wrong" }
  end
end
