require "net/http"
require "json"

class HttpExecutor
  def initialize(context, step)
    @context = context
    @step = step
  end

  def call
    uri = URI(@step["url"])

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri)

    @step["headers"].each do |key, value|
      request[key] = value
    end

    body = @step["body"]["value"]
    body["text"] = @context["title"]
    request.body = JSON.generate(body)
    response = http.request(request)
  end
end
