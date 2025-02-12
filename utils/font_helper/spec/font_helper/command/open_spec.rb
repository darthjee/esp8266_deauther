# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::Command::Open do
  subject(:command) { described_class.new(script, path) }

  let(:path)          { 'spec/support/fixtures/font.txt' }
  let(:context)       { FontHelper::ScriptContext.new }
  let(:expected_font) { FontHelper::FontLoader.load(path) }
  let(:script)        { FontHelper::Script.new(SecureRandom.hex(32), context:) }

  describe '#run' do
    it 'loads the font' do
      expect { command.run }
        .to change(context, :font)
        .from(nil)
        .to(expected_font)
    end
  end
end
