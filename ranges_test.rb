require 'minitest/autorun'
require_relative 'ranges'

class RangesTest < Minitest::Test
  def test_shorten_returns_response
    ranges_processor = Ranges.new('')
    assert ranges_processor.shorten != nil
  end

  def test_shorten_returns_valid_response
    ranges_processor = Ranges.new('abcdab987612')
    assert ranges_processor.shorten == 'a-dab9-612'
  end

  def test_shorten_returns_valid_response
    ranges_processor = Ranges.new('abcbdab987612')
    assert ranges_processor.shorten == 'a-cbdab9-612'
  end
end
