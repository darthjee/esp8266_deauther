# frozen_string_literal: true

class FontHelper
  class BitMap
    module BitOperations
      def bit_at(line:, column:)
        return 0 unless bitmap[column]

        bitmap[column][line] || 0
      end

      def crop(top: 0, bottom: 0)
        bits = top + bottom
        return if bits.zero?

        @bitmap = bitmap.map do |column|
          column[top, height - bits]
        end

        @height = height - bits
        @byte_height = nil
      end

      private

      def generate_bitmap
        bytes_columns.map do |column|
          column.map do |byte|
            BinaryConverter.to_bits(byte)
          end.flatten[0, height]
        end
      end
    end
  end
end
