# frozen_string_literal: true

class FontHelper
  class Command
    class Remove < Command
      delegate :delete, to: :font

      alias codes arguments

      def run
        codes.each do |code|
          delete(code)
        end
      end
    end
  end
end
