# frozen_string_literal: true

class FontHelper
  class Command
    class Crop < Command
      attr_reader :top, :bottom

      comparable_by :top, :bottom

      def initialize(script, top: 0, bottom: 0)
        @top = top
        @bottom = bottom
        super(script)
      end

      def run
        font.crop(top:, bottom:)
      end
    end
  end
end
