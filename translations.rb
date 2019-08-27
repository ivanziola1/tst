require 'yaml'
require_relative 'advanced_hash'

class Translations
  class FileIsNotExistError < StandardError; end

  KEYSET_REGEXP = /^'|'$/
  KEY_VALUE_SPLITTER = ':'.freeze
  KEYSET_SPLITTER = '.'.freeze

  attr_reader :input_file, :output_file

  def initialize(input_file, output_file)
    @input_file = input_file
    @output_file = output_file
  end

  def call
    raise FileIsNotExistError unless File.exist?(input_file)

    translations = File.readlines(input_file).map do |line|
      translation_hash = AdvancedHash.new
      line.strip!
      # next if line.start_with?('#')
      key_set, value = line.split(KEY_VALUE_SPLITTER)
      key_set.gsub!(KEYSET_REGEXP, '')
      keys = key_set.split(KEYSET_SPLITTER)
      translation_hash.nested_set(keys, value.strip)
      translation_hash
    end

    translation = translations.reduce(AdvancedHash.new, :deep_merge)
    File.open(output_file, 'w') do |file|
      file.write(translation.to_h.to_yaml)
    end
  end
end
