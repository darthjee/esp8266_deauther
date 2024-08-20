# frozen_string_literal: true

class FontHelper
  class Command
    class ReadImages < Command
      attr_reader :path

      comparable_by :path

      def initialize(script, path)
        @path = path
        super(script)
      end

      def run
        paths.each do |path|
          code = path.gsub(%r{.*/}, '').gsub(/\..*/, '').to_i
          ReadImage.new(script, code:, path:).run
        end
      end

      def paths
        Dir["#{path}/*.pbm"]
      end
    end
  end
end
