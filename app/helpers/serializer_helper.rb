# frozen_string_literal: true

module SerializerHelper
  def bulk_serialize(serializer, bulk_data, is_paginated = false)
    records = bulk_data.map { |row| serialize(serializer, row) }
    return records unless is_paginated

    {
      records: records,
      current_page: bulk_data.current_page,
      total_pages: bulk_data.total_pages,
      previous_page: bulk_data.previous_page,
      next_page: bulk_data.next_page,
    }
  end

  def serialize(serializer, data)
    return nil unless data
    serializer.new(data).as_json
  end

  def serialize_static_hash(base_hash_array, value)
    base_hash_array.find{ |element| element[:value] == value }
  end
end
