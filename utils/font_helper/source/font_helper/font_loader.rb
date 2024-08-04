# frozen_string_literal: true

class FontHelper
  class FontLoader
    attr_reader :path

    def self.load(path)
      new(path).load
    end

    def initialize(path)
      @path = path
    end

    def load
      FontBuilder.build(*binaries)
    end

    private

    def binaries
      FileLoader.read(path)
    end
  end
end
