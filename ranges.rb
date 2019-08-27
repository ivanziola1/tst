require_relative 'advanced_array'
class Ranges
  attr_reader :input_string

  def initialize(input_string)
    @input_string = input_string
  end

  def shorten
    possible_ranges = []
    input_string.each_char.with_index do |chr, i|
      next_index = i + 1
      possible_ranges << diff(i, next_index)
    end

    with_checked_order = possible_ranges.map.with_index do |el, i|
      prev_index = i - 1
      next el if el.empty? || prev_index < 0

      prev = possible_ranges[prev_index]
      next el if prev.empty?

      prev_diff = prev[0].ord - prev[-1].ord
      el[0].ord - el[-1].ord != prev_diff ? ['', el] : el
    end.flatten

    AdvancedArray.new(with_checked_order).split('').each do |arr|
      next if arr.length <= 1

      range_array = arr.map { |el| el[0] } << arr.last[-1]
      range = range_array.join
      next if range.nil?

      input_string.gsub!(range, shorter(range))
    end

    input_string
  end

  private

  def diff(current_index, next_index)
    return '' if next_index >= input_string.length

    current_char  = input_string[current_index]
    next_char = input_string[next_index]
    difference = current_char.ord - next_char.ord
    return '' if difference.abs != 1

    diff(next_index, next_index + 1)
    current_char + next_char
  end

  def shorter(range)
    "#{range[0]}-#{range[-1]}"
  end
end
