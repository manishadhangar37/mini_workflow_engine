class WorkflowsController < ApplicationController
    def new
        @workflow = Workflow.new
    end
    def index
        @workflows = Workflow.all
    end

    def create
        @workflow = Workflow.new(workflow_params)
        
    if @workflow.save
      redirect_to workflows_path
    else    
      render :new, status: :unprocessable_entity
    end
  end

  private 
  def workflow_params
    params.require(:workflow).permit(:name, :enabled, :defination_jason)
    end
end
