# frozen_string_literal: true

class FontHelper
  class Command
    class Open < Command
      attr_reader :path

      comparable_by :path

      def initialize(script, path)
        @path = path
        super(script)
      end

      def run
        self.font = FontHelper::FontLoader.load(path)
      end
    end
  end
end
