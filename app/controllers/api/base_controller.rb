module Api
  class BaseController < ActionController::API
    include OauthTokensConcern
    include ExceptionHandlerConcern
    include ActionController::Cookies
    include Pundit

    # =======End include module======

    def serialize(resource, option = {})
      ActiveModelSerializers::SerializableResource.new(
        resource,
        option
      ).serializable_hash.as_json
    end

    def error_response(resource, error)
      {
        success: false,
        full_messages: resource&.errors&.full_messages,
        errors: resource&.errors,
        error_message: error.message,
        backtrace: error.backtrace
      }
    end
  end
end
