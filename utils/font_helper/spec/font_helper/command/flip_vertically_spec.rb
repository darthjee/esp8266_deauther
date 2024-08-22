# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::Command::FlipVertically do
  subject(:command) { described_class.new(script, code) }

  let(:code)        { (48..58).to_a.sample }

  let(:font) { FontHelper::FontLoader.load(font_path) }
  let(:font_path) { 'spec/support/fixtures/font_simplified.txt' }

  let(:context)    { FontHelper::ScriptContext.new(font:) }
  let(:script)     { FontHelper::Script.new(SecureRandom.hex(32), context:) }

  let(:expected_character) { FontHelper::ImageReader.read(code, sample_path) }
  let(:sample_path) { "spec/support/fixtures/vertical_flipped_images/#{code}.pbm" }

  describe '#run' do
    it do
      expect { command.run }
        .to change { font.character(code).binary }
        .to(expected_character.binary)
    end
  end
end
