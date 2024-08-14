# frozen_string_literal: true

class FontHelper
  class Command
    class Remove < Command
      alias codes arguments

      def run
        codes.each do |code|
          font.characters.delete(code)
        end
      end
    end
  end
end
