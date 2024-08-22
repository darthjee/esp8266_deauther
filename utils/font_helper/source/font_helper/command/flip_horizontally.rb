# frozen_string_literal: true

class FontHelper
  class Command
    class FlipHorizontally < Command
      delegate :flip_horizontally, :character, to: :font

      alias codes arguments

      def run
        codes.each do |code|
          character(code).flip_horizontally
        end
      end
    end
  end
end
