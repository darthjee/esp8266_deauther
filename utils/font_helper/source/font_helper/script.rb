class FontHelper
  class Script
    def process(*)
      new(*).process
    end

    attr_reader :path

    def initialize(path)
      @path = path
    end

    def process
    end
  end
end
