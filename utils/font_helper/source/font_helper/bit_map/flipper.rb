# frozen_string_literal: true

class FontHelper
  class BitMap
    module Flipper
      def flip_vertically
        bitmap.size.times do |index|
          column = bitmap[index]
          bitmap[index] = column.reverse
        end
      end

      def flip_horizontally
        bitmap.ensure_size!(width) { [].ensure_size!(height) { 0 } }

        (width / 2).times do |index|
          aux = bitmap[index]
          other = bitmap[width - index - 1]
          bitmap[index] = other
          bitmap[width - index - 1] = aux
        end
      end
    end
  end
end
