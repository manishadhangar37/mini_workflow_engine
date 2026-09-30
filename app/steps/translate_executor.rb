class TranslateExecutor
  def initialize(context, ops)
    @context = context
    @ops = ops
  end

  def call
    @ops.all? do |operation|
      case operation["op"]
      when "default"
        path = operation["path"]
        if @context[path].nil?
          @context[path] = operation["value"]
        end
      when "template"
        template = operation["template"]
        @context[operation["to"]] = operation["template"].gsub("{{type}}", @context["type"]).gsub("{{actor_name}}", @context["actor_name"])
      end
    end
    @context
  end
end
