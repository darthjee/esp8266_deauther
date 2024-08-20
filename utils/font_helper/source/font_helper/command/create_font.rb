# frozen_string_literal: true

class FontHelper
  class Command
    class CreateFont < Command
      attr_reader :height, :width

      comparable_by :height, :width

      def initialize(script, height:, width:)
        @height = height
        @width = width
        super(script)
      end

      def run
        self.font = Font.new(height:, width:)
      end
    end
  end
end
