module ExceptionHandlerConcern
  rescue_from ActiveRecord::RecordNotFound, with: :base_render_record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :base_render_unprocessable_entity
  rescue_from Exceptions::AuthenticationError, with: :base_render_authentication_error
  rescue_from ActiveRecord::RecordNotUnique, with: :base_render_record_not_unique
  rescue_from Pundit::NotAuthorizedError, with: :base_render_unauthorized_error

  private

  def base_render_record_not_found(exception)
    render json: { message: exception.message }, status: :not_found
  end

  def base_render_unprocessable_entity(exception)
    render json: { message: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  def base_render_authentication_error(exception)
    render json: { message: exception.message }, status: :not_found
  end

  def base_render_unauthorized_error(_exception)
    render json: { message: I18n.t('errors.unauthorized_error') }, status: :unauthorized
  end

  def base_render_record_not_unique
    render json: { message: I18n.t('errors.record_not_uniq_error') }, status: :forbidden
  end
end
