# frozen_string_literal: true

class FontHelper
  class Command
    class RemoveRange < Remove

      def initialize(script, first, last)
        super(script)
        @arguments = (first..last).to_a
      end
    end
  end
end
