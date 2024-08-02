# frozen_string_literal: true

class FontHelper
  class FileLoader
    attr_reader :path

    def initialize(path)
      @path = path
    end

    private

    def file_loader
      FileLoader.new(file)
    end
  end
end
