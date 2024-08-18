# frozen_string_literal: true

class FontHelper
  class Command
    class RemoveRange < Remove

      def initialize(script, first, last)
        @argument = (first..last).to_a
      end
    end
  end
end
