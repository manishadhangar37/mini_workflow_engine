class FilterExecutor
    def initialize(context, conditions)
        @context = context
        @conditions = conditions
    end

    def call
        @conditions.all? do |condition|
            value = @context[condition["path"]]

            case condition["op"]
            when "eq"
                value == condition["value"]

            when "neq"
                value != condition["value"]
            end
        end
    end
end
