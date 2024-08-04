class FontHelper
  class Command
    class Open < Command
      attr_reader :path

      comparable_by :path

      def initialize(path)
        @path = path
      end

      def run(context)
        context.font = FontHelper::FontLoader.load(path)
      end
    end
  end
end
