# frozen_string_literal: true

module RenderHelper
  include SerializerHelper
  def not_found_response(e)
    error_response(e, :not_found)
  end

  def bad_request_response(e)
    error_response(e, :bad_request)
  end

  def success_response(data = nil, message = nil, status = :ok)
    default_response(true, data, nil, message, status || :ok)
  end

  def success_serialized_response(serializer, data, message = nil, status = :ok)
    success_response(serialize(serializer, data), message, status)
  end

  def success_bulk_serialized_paginated_response(serializer, data, message = nil, status = :ok)
    success_response(bulk_serialize(serializer, data, true), message, status)
  end

  def success_bulk_serialized_response(serializer, data, message = nil, status = :ok)
    success_response(bulk_serialize(serializer, data), message, status)
  end

  def error_response(err, status = :unprocessable_entity)
    err.backtrace.each { |row| Rails.logger.info row }
    error = err.record ? err.record.errors : [err.message]
    message = err.message
    default_response(false, nil, error, message, status || :unprocessable_entity)
  rescue => _
    error = [err.message]
    message = err.message
    default_response(false, nil, error, message, status || :unprocessable_entity)
  end

  def default_response(success, data = nil, errors = nil, message = true, status = :ok)
    render json: {
      success: success,
      data: data,
      errors: errors,
      message: message,
      status: status || (success ? :ok : :unprocessable_entity)
    }, status: status || (success ? :ok : :unprocessable_entity)
  end
end
