# frozen_string_literal: true

class FontHelper
  class FileLoader
    attr_reader :path

    def self.read(path)
      new(path).read
    end

    def initialize(path)
      @path = path
    end

    def read
    end

    private

    def file
      @file ||= File.open(file, "r")
    end
  end
end
