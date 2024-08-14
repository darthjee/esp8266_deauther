# frozen_string_literal: true

class FontHelper
  class Command
    class Write < Command
      attr_reader :path

      comparable_by :path

      def initialize(script, path)
        @path = path
        super(script)
      end

      def run(context)
        FontHelper::FontWritter.write(context.font, path)
      end
    end
  end
end
