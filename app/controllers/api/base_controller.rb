# frozen_string_literal: true

module Api
  class BaseController < ApplicationController
    before_action :set_default_response_format

    rescue_from StandardError do |e|
      # Raise exception only for dev env
      raise e unless Rails.env.production? || ENV['CATCH_EXCEPTION_DURING_TEST']

      render_message(500, 'Internal Server Error')
    end

    rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError do
      render_message(404, 'Not found')
    end

    rescue_from ActionController::ParameterMissing do
      render_message(422, 'Parameters are missing')
    end

    # method called during invalid route (see config/routes.rb)
    def catch_404
      raise ActionController::RoutingError, params[:path]
    end

    private

    def set_default_response_format
      request.format = :json
    end

    def render_message(code, message)
      render json: { code: code.to_s, message: message }, status: code
    end

    def render_errors(errors)
      render json: { code: '422', message: 'Validation Failed', errors: errors.messages }, status: :unprocessable_entity
    end
  end
end
