# frozen_string_literal: true

class FontHelper
  class Command
    include Sinclair::Comparable

    autoload :Open,         'font_helper/command/open'
    autoload :Write,        'font_helper/command/write'
    autoload :Remove,       'font_helper/command/remove'
    autoload :RemoveRange,  'font_helper/command/remove_range'
    autoload :Crop,         'font_helper/command/crop'
    autoload :ReadImage,    'font_helper/command/read_image'
    autoload :ReadImages,   'font_helper/command/read_images'
    autoload :CreateFont,   'font_helper/command/create_font'
    autoload :AddCharacter, 'font_helper/command/add_character'
    autoload :WriteImage,   'font_helper/command/write_image'
    autoload :WriteImages,  'font_helper/command/write_images'

    autoload :FlipVertically,  'font_helper/command/flip_vertically'

    delegate :font, :font=, to: :script

    class << self
      def for(command:, script:, arguments:)
        klass = const_get(command)

        args = arguments_list(arguments)
        opts = options(arguments).symbolize_keys

        klass.new(script, *args, **opts)
      end

      def arguments_list(arguments)
        return [] if arguments.is_a?(Hash)
        return [arguments] unless arguments.is_a?(Array)

        arguments.reject { |arg| arg.is_a?(Hash) }
      end

      def options(arguments)
        return arguments if arguments.is_a?(Hash)
        return {} unless arguments.is_a?(Array)

        arguments.select { |arg| arg.is_a?(Hash) }.map.with_object({}) do |opt, hash|
          hash.merge!(opt)
        end
      end
    end

    attr_reader :arguments, :script

    def initialize(script, *arguments)
      @script    = script
      @arguments = arguments
    end
  end
end
