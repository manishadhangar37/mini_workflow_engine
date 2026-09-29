class WorkflowRunsController < ApplicationController
 
    def create
        workflow = Workflow.find_by(trigger_path: params[:path])
        
        unless workflow.enabled? 
         render json: { error: "Workflow is disabled" }, status: :forbidden 
        end
         
        workflow_run = workflow.workflow_runs.create!( input_payload: {type: params[:type],success: params[:success], actor: params[:actor]}, started_at: Time.current,)
        workrunner = WorkflowRunner.new(workflow,workflow_run)
        workrunner.call
        
    end

    
     
end
