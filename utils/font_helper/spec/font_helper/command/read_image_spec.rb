# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::Command::ReadImage do
  subject(:command) { described_class.new(script, code:, path:) }

  let(:code)      { (48..58).to_a.sample }
  let(:path)      { "spec/support/fixtures/images/#{code}.pbm" }

  let(:font)       { build(:font, characters:) }
  let(:characters) { [build(:character, code:, binary: [255])] }

  let(:context)    { FontHelper::ScriptContext.new(font:) }
  let(:script)     { FontHelper::Script.new(SecureRandom.hex(32), context:) }

  let(:expecrted_font)     { FontHelper::FontLoader.load(expected_font_path) }
  let(:expected_font_path) { 'spec/support/fixtures/font_simplified.txt' }
  let(:expected_character) { expecrted_font.character(code) }

  describe '#run' do
    it do
      expect { command.run }
        .to change { font.character(code) }
        .from(characters.first)
        .to(expected_character)
    end
  end
end
