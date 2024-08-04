class FontHelper
  class Command
    include Sinclair::Comparable

    autoload :Open, 'font_helper/command/open'

    def self.for(command:, arguments:)
      klass = self.const_get(command)
      klass.new(*arguments)
    end

    attr_reader :arguments

    def initialize(*arguments)
      @arguments = arguments
    end
  end
end
