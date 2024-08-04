class FontHelper
  class Script
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def commands
      @commands ||= read_commands
    end

    private

    def read_commands
      YAML.load(file_content)
    end

    def file_content
      File.read(path)
    end
  end
end
