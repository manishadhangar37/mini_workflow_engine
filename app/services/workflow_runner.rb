class WorkflowRunner
  def initialize(workflow, workflow_run)
    @workflow = workflow
    @workflow_run = workflow_run
  end

  def call
    context = @workflow_run.input_payload
    defination = JSON.parse(@workflow.defination_jason)

    steps = defination["steps"]

    steps.each do |step|
      case step["type"]
      when "filter"
        result = FilterExecutor.new(context, step["conditions"]).call

        unless result
          @workflow_run.update(status: :skipped, error_message: { messgae: "workfkow filter step failed" }, finished_at: Time.current)
          return result
        end

      when "transform"
        context_message = TranslateExecutor.new(context, step["ops"]).call

      when "http_request"
        response = HttpExecutor.new(context, step).call

        return response.code

      end
    end
  end
end
