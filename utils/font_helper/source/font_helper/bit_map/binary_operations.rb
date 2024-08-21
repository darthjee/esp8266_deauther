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
          column.each_slice(8).map do |bits|
            BinaryConverter.to_byte(bits)
          end
        end.flatten
      end
    end
  end
end
