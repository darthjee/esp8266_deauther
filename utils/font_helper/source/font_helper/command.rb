# frozen_string_literal: true

class FontHelper
  class Command
    include Sinclair::Comparable

    autoload :Open,  'font_helper/command/open'
    autoload :Write, 'font_helper/command/write'

    def self.for(command:, arguments:)
      klass = const_get(command)
      klass.new(*arguments)
    end

    attr_reader :arguments

    def initialize(*arguments)
      @arguments = arguments
    end
  end
end
