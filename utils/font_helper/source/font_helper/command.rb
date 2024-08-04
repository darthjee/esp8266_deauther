class FontHelper
  class Command
    def self.for(command:, arguments:)
      new(*arguments)
    end

    attr_reader :arguments

    def initialize(*arguments)
      @arguments = arguments
    end
  end
end
