# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::Command::Write do
  subject(:command) { described_class.new(script, path) }

  let(:path)      { "/tmp/font_#{SecureRandom.hex(32)}.txt" }
  let(:context)   { FontHelper::ScriptContext.new(font:) }
  let(:font)      { FontHelper::FontLoader.load(font_path) }
  let(:font_path) { 'spec/support/fixtures/font.txt' }
  let(:script)    { FontHelper::Script.new(SecureRandom.hex(32), context:) }

  describe '#run' do
    it 'creates the font file' do
      expect { command.run }
        .to change { File.exist?(path) }
        .from(false).to(true)
    end

    it 'writes the font data' do
      command.run

      expect(File.read(path)).to eq(File.read(font_path))
    end

    context 'when font needs to be trimmed' do
      let(:font_path) { 'spec/support/fixtures/font_to_trim.txt' }
      let(:expected_font_path) { 'spec/support/fixtures/font.txt' }

      it 'creates the font file' do
        expect { command.run }
          .to change { File.exist?(path) }
          .from(false).to(true)
      end

      it 'writes the font data' do
        command.run

        expect(File.read(path)).to eq(File.read(expected_font_path))
      end
    end
  end
end
