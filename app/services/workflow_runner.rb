class WorkflowRunner
  def initialize(workflow, workflow_run)
    @workflow = workflow
    @workflow_run = workflow_run
  end

  def call
    context = @workflow_run.input_payload

    steps = @workflow.defination_jason
    byebug

   end


 

end



