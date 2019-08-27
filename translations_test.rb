require 'minitest/autorun'
require_relative 'translations'

class TranslationsTest < Minitest::Test
  def test_raises_an_error
    assert_raises Translations::FileIsNotExistError do
      translations = Translations.new('translations_sample.yml', 'translations.yml')
      translations.call
    end
  end

  def test_process_with_valid_data
    example = YAML.load(File.read('translations_example.yml'))
    translations = Translations.new('translations_simple.yml', 'translations.yml')
    translations.call
    processed = YAML.load(File.read('translations.yml'))
    assert processed == example
  end
end
