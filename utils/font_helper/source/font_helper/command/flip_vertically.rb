# frozen_string_literal: true

class FontHelper
  class Command
    class FlipVertically < Command
      delegate :flip_vertically, :character, to: :font

      alias codes arguments

      def run
        codes.each do |code|
          character(code).flip_vertically
        end
      end
    end
  end
end
