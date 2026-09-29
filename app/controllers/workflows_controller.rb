class WorkflowsController < ApplicationController
    before_action :set_workflow, only: [:update, :edit, :show, :destroy ]
  
  def new
        @workflow = Workflow.new
  end
  
  def show
  
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

  def edit
  end
  
  def update
    if @workflow.update(workflow_params)
      redirect_to workflow_path(@workflow)
    else
      render :edit, status: :unprocessable_entity
    end
  end

    def destroy
      if @workflow.destroy
        redirect_to workflows_path
      end
    end

    

  private 
  def workflow_params
    params.require(:workflow).permit(:name, :enabled, :defination_jason)
  end

  def set_workflow
    @workflow = Workflow.find(params[:id])
  end
end

     
