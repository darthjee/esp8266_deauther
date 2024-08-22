# frozen_string_literal: true

class FontHelper
  class BitMap
    module BinaryOperations
      def binary
        @binary ||= generate_binary.tap do
          @bitmap = nil
        end
      end

      private

      def bytes_columns
        binary.each_slice(byte_height).to_a
      end

      def generate_binary
        return [] unless @bitmap

        bitmap.map do |column|
          BinaryConverter.convert_to_bytes(column)
        end.flatten
      end
    end
  end
end
