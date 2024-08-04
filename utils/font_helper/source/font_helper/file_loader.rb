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
      file.read
          .gsub(%r{//.*$}, '')
          .gsub(/\s/, '')
          .split(',')
          .map { |hex| hex.to_i(16) }
    end

    private

    def file
      @file ||= File.open(path, 'r')
    end
  end
end
