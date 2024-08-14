# frozen_string_literal: true

class FontHelper
  class Script
    include Sinclair::Comparable

    attr_reader :path

    comparable_by :path, :context

    delegate :font, :font=, to: :context

    def initialize(path, context: nil)
      @path    = path
      @context = context
    end

    def commands
      @commands ||= read_commands
    end

    def run
      commands.each(&:run)
    end

    private

    def context
      @context ||= ScriptContext.new
    end

    def read_commands
      YAML.load(file_content).map(&:symbolize_keys).map do |hash|
        Command.for(script: self, **hash)
      end
    end

    def file_content
      File.read(path)
    end
  end
end
