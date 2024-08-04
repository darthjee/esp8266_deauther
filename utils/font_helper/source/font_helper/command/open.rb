class FontHelper
  class Command
    class Open < Command
      attr_reader :path

      comparable_by :path

      def initialize(path)
        @path = path
      end
    end
  end
end
