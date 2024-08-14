# frozen_string_literal: true

class FontHelper
  class Script
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def commands
      @commands ||= read_commands
    end

    def run
      commands.each do |command|
        command.run(context)
      end
    end

    private

    def context
      @context ||= ScriptContext.new
    end

    def read_commands
      YAML.load(file_content).map(&:symbolize_keys).map do |hash|
        Command.for(**hash)
      end
    end

    def file_content
      File.read(path)
    end
  end
end
