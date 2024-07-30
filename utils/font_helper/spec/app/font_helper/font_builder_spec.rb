# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::FontBuilder do
  let(:width) { 24 }
  let(:height) { 32 }
  let(:first_character) { 48 }
  let(:character_bytes) { Random.rand(2..10) }
  let(:character_width) { Random.rand(10..30) }

  let(:font_binary) do
    build(
      :font_binary,
      width:, height:, first_character:, characters_count:,
      character_bytes:, character_width:
    )
  end

  let(:expected_font) do
    FontHelper::Font.new(width:, height:)
  end

  context 'when no char data is given' do
    let(:characters_count) { 0 }

    it do
      expect(described_class.build(*font_binary))
        .to be_a(FontHelper::Font)
    end

    it "Returns Font with expected attributes" do
      expect(described_class.build(*font_binary))
        .to eq(expected_font)
    end
  end
end
