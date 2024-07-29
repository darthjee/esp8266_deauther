class FontHelper
  class Font
    attr_reader :width, :height

    delegate :<<, to: :characters

    def initialize(width, height, characters = nil)
      @width = width
      @height = height
      @characters = characters
    end

    def characters
      @character ||= []
    end

    def quantity
      characters.size
    end
  end
end
