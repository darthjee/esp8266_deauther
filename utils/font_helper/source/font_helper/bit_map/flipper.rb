# frozen_string_literal: true

class FontHelper
  class BitMap
    module Flipper
      def flip_vertically
        bitmap.size.times do |index|
          column = bitmap[index]
          column.fill(0, column.size, height - column.size)
          bitmap[index] = column.reverse
        end
      end
    end
  end
end
