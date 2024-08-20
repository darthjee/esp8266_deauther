# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::Command::ReadImages do
  subject(:command) { described_class.new(script, path:) }

  let(:path)      { "spec/support/fixtures" }

  let(:height) { 24 }
  let(:width) { 24 }
  let(:font)       { build(:font, characters:, height:, width:) }
  let(:characters) { [build(:character, code: 35, binary: [255])] }

  let(:context)    { FontHelper::ScriptContext.new }
  let(:script)     { FontHelper::Script.new(SecureRandom.hex(32), context:) }

  let(:expected_font)      { FontHelper::FontLoader.load(expected_font_path) }
  let(:expected_font_path) { 'spec/support/fixtures/font_simplified.txt' }

  before do
    context.font = font
  end

  describe '#run' do
    it 'adds the new characters' do
      expect { command.run }
        .to change { font.characters.keys }
        .from([35])
        .to([35] + (48..58).to_a)
    end

    context 'after loading' do
      let(:characters) { [] }

      before do
        command.run
      end

      it 'parse all images' do
        expect(font).to eq(expected_font)
      end
    end
  end
end
