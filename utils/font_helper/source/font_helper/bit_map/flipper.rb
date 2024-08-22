# frozen_string_literal: true

class FontHelper
  class BitMap
    module Flipper
      def flip_vertically
        bitmap.size.times do |index|
          column = bitmap[index]
          column.ensure_size!(height) { 0 }
          bitmap[index] = column.reverse
        end
      end

      def flip_horizontally
        (width / 2).times do |index|
          aux = bitmap[index] || height.times.map { 0 }
          other = bitmap[width - index - 1] || height.times.map { 0 }
          bitmap[index] = other.ensure_size!(height) { 0 }
          bitmap[width - index - 1] = aux.ensure_size!(height) { 0 }
        end
      end
    end
  end
end
