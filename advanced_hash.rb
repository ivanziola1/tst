class AdvancedHash < Hash
  def nested_set(keys, value)
    final_key = keys.pop
    return unless valid_key?(final_key)
    position = self
    for key in keys
      return unless valid_key?(key)
      position[key] = {} unless position[key].is_a?(Hash)
      position = position[key]
    end
    position[final_key] = value
  end

  def deep_merge(second)
    merger = proc { |key, v1, v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : v2 }
    self.merge(second, &merger)
  end

  private

  def valid_key?(key)
    return true if key.is_a?(Symbol) || key.is_a?(String)
  end
end
