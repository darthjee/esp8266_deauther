# frozen_string_literal: true

class FontHelper
  class Command
    class WriteImages < Command
      attr_reader :path

      comparable_by :path

      def initialize(script, path:)
        @path = path
        super(script)
      end

      def run
        characters.each do |character|
          image_path = "#{path}/#{character.code}.pbm"
          ImageWritter.write(character, image_path)
        end
      end

      def characters
        font.characters.values
      end
    end
  end
end
