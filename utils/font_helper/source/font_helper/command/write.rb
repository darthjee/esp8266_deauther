# frozen_string_literal: true

class FontHelper
  class Command
    class Write < Command
      attr_reader :path

      comparable_by :path

      def initialize(path)
        @path = path
        super
      end

      def run(context)
        FontHelper::FontWritter.write(context.font, path)
      end
    end
  end
end
