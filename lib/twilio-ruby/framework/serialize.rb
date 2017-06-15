module Twilio
  def self.serialize_iso8601(date)
    date.iso8601 if date
  end

  def self.deserialize_rfc2822(date)
    Time.rfc2822(date) unless date.nil?
  end

  def self.deserialize_iso8601(date)
    Time.parse(date) unless date.nil?
  end

  def self.serialize_object(object)
    if object.is_a?(Hash) || object.is_a?(Array)
      JSON.generate(object)
    else
      object
    end
  end

  def self.flatten(map, result = {}, previous = [])
    map.each do |key, value|
      if value.is_a? Hash
        flatten(value, result, previous + [key])
      else
        result[(previous + [key]).join('.')] = value
      end
    end

    result
  end

  def self.prefixed_collapsible_map(map, prefix)
    result = {}
    if map.is_a? Hash
      flattened = flatten(map)
      result = {}
      flattened.each do |key, value|
        result[prefix + '.' + key] = value
      end
    end

    result
  end
end
