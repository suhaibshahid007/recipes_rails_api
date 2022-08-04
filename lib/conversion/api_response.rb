module Conversion
  class ApiResponse
    attr_reader :body, :status
    def initialize(body, status)
      @body = body
      @status = status
    end

    def to_json(*args)
      response = if body.is_a?(Float)
                    { result: body }
                  else
                    { errors: body }
                  end
      response.to_json(*args)
    end
  end
end
