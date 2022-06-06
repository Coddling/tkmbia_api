module ModelHelper
  def get_resource(class_, search_by, search_value, message_=nil, custom_exception_=nil)
    @resource = class_.find_by( "#{search_by}" => search_value)
    message = message_ || "#{class_.to_s} not found"
    exception = custom_exception_ || ExceptionHandler::NotFoundError
    raise exception.new(message) if @resource.nil?
    return @resource
  end

  def get_filtered_and_paginated_records(class_)
    class_::FilterSerializer.apply(filter_params).order("id desc").with_paginate_10((filter_params[:page] || 1))
  end
end