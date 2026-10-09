class WorkflowsController < ApplicationController
  before_action :set_workflow, only: [ :update, :edit, :show, :destroy ]
  rescue_from ActiveRecord::RecordNotFound, with: :workflow_not_found

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
    begin
      JSON.parse(@workflow.defination_jason)
    rescue JSON::ParserError
      return render json: { error: "Invalid JSON" }, status: :unprocessable_entity
    end

    return if @workflow.defination_jason == "{}"

    if @workflow.save
     redirect_to workflow_path(@workflow)
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
    unless @workflow.destroy
      render json: { error: "can't destroy" }
    end
  end

  private
  def workflow_params
    params.require(:workflow).permit(:name, :enabled, :defination_jason)
  end

  def set_workflow
    @workflow = Workflow.find(params[:id])
  end

  def workflow_not_found
    render json: { messagge: "workflow not found" }
  end
end
