class Api::V1::BaseController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session
  before_action :destroy_session
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def destroy_session
    request.session_options[:skip] = true
  end

  def not_found
    return api_error(status: 404, errors: 'Not found')
  end

  def api_error(msg, error_code=401)
    render json: {error: msg}, status: error_code
  end

  def api_ok(msg="")
    msg = "ok" if msg.blank?
    render json: msg.to_json
  end

  def api_404(*args)
    err = args.first

    msg = case err.class
      when ActiveRecord::RecordNotFound
        "#{infer_object_name} not found"
      when ActionController::RoutingError
        "endpoint not found"
      else
        err
      end

    render json: {error: msg}, status: 404
  end

  def api_permissions_error(*args)
    err = args.first

    msg = if msg.is_a? Api::PermissionsError
        "not permitted to access that #{infer_object_name}"
      else
        err
      end
    
    render json: {error: msg}, status: 401
  end

end
