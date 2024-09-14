class ApplicationController < ActionController::API
  before_action :validate_request!

  protected

  def validate_request!
    schema = self.class.const_get("#{controller_name.camelize}#{action_name.camelize}Schema")
    result = schema.call(params.to_unsafe_h)

    if result.success?
      @validated_params = result.to_h
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
      false
    end
  end
end
