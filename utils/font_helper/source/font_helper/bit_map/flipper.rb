# frozen_string_literal: true

class FontHelper
  class BitMap
    module Flipper
      def flip_vertically
        bitmap.size.times do |index|
          bitmap[index].reverse!
        end
      end
    end
  end
end
