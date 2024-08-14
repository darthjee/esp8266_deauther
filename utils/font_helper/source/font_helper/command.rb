# frozen_string_literal: true

class FontHelper
  class Command
    include Sinclair::Comparable

    autoload :Open,  'font_helper/command/open'
    autoload :Write, 'font_helper/command/write'

    delegate :font, :font=, to: :script

    def self.for(command:, script:, arguments:)
      klass = const_get(command)
      klass.new(script, *arguments)
    end

    attr_reader :arguments, :script

    def initialize(script, *arguments)
      @script = script
      @arguments = arguments
    end
  end
end
