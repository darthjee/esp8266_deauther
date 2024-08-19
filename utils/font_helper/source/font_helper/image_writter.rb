# frozen_string_literal: true

class FontHelper
  class ImageWritter
    attr_reader :character, :path

    delegate :width, :height, to: :character

    def self.write(character, path)
      new(character, path).write
    end

    def initialize(character, path)
      @character = character
      @path = path
    end

    def write
    end
  end
end
