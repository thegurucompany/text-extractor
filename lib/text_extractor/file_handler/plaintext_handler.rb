# frozen_string_literal: true

module TextExtractor
  class PlaintextHandler < FileHandler
    CONTENT_TYPES = %w(text/csv text/plain application/json)
    def initialize
      @content_types = CONTENT_TYPES
    end

    def text(file)
      TextExtractor::CodesetUtil.to_utf8 file.read, 'UTF-8'
    end
  end
end