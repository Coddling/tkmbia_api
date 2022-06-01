module ExceptionHandler
  module ApiException
    include RenderHelper

    def self.included(clazz)
      clazz.class_eval do
        rescue_from Exception, with: :error_response
        rescue_from ActiveRecord::RecordInvalid, with: :bad_request_response
        rescue_from ExceptionHandler::BadRequestError, with: :bas_request_response
        rescue_from ExceptionHandler::UnauthorizedError, with: :unauthorized_request_response
        rescue_from ExceptionHandler::ForbiddenPermissionsError, with: :forbidden_request_response
        rescue_from ExceptionHandler::UnprocessableEntityError, with: :unprocessable_entity_response
        
        rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
        rescue_from ExceptionHandler::NotFoundError, with: :not_found_response

        def raise_unauthorized(message)
          raise ExceptionHandler::UnauthorizedError, message
        end

        def raise_forbidden(message)
          raise ExceptionHandler::ForbiddenPermissionsError, message
        end

        def raise_bad_request(message)
          raise ExceptionHandler::BadRequestError, message
        end

        def raise_unprocessable_entity(message)
          raise ExceptionHandler::BadRequestError, message
        end
        
      end
    end

    private

    def bad_request_response(err)
      error_response(err, :bad_request)
    end

    def unauthorized_request_response(err)
      error_response(err, :unauthorized)
    end

    def forbidden_request_response(err)
      error_response(err, :forbidden)
    end

    def unprocessable_entity_response(err)
      error_response(err, :unprocessable_entity)
    end
    
  end

  class BaseError < StandardError
    attr_accessor :record

    def initialize(message, record_ = nil)
      @message = message
      @record = record_
      super(message)
    end
  end

  class NotFoundError < BaseError; end

  class BadRequestError < BaseError; end

  class UnauthorizedError < BaseError; end

  class ForbiddenPermissionsError < BaseError; end

  class UnprocessableEntityError < BaseError; end

end
