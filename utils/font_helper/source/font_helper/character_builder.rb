# frozen_string_literal: true

class FontHelper
  class CharacterBuilder
    attr_reader :height, :code, :first_byte_1, :first_byte_2, :bytes, :width, :binaries

    class << self
      def build(*)
        new(*).build
      end
    end

    def initialize(height, code, character_information, *binaries)
      @height = height
      @code = code
      (@first_byte_1, @first_byte_2, @bytes,@width) = character_information 
      @binaries = binaries
    end

    def build
      Character.new(code:, width:, binary:)
    end

    private

    def binary
      binaries
    end
  end
end
