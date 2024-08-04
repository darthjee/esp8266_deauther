class FontHelper
  class Command
    class Open < Command
      attr_reader :path

      def initialize(path)
        @path = path
      end
    end
  end
end
