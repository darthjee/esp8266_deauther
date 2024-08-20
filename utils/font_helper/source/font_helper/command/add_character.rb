# frozen_string_literal: true

class FontHelper
  class Command
    class AddCharacter < Command
      attr_reader :code, :binary

      delegate :height, to: :font
      comparable_by :code, :width, :binary

      def initialize(script, code:, width: nil, binary: nil)
        @code = code
        @width = width
        @binary = binary
        super(script)
      end

      def run
        font << character
      end

      private

      def character
        Character.new(code:, width:, binary:, height:)
      end

      def width
        @width ||= font.width
      end
    end
  end
end
