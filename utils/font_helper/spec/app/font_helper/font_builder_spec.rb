# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::FontBuilder do
  let(:width) { 24 }
  let(:height) { 32 }
  let(:first_char) { 48 }
  let(:char_size) { Random.rand(2..10) }
  let(:char_width) { Random.rand(10..30) }
  let(:characters) do
    char_count.times.map do |index|
      start_position  = index * char_size
      [start_position / 256, start_position  % 256, char_size, char_width ]
    end
  end
  let(:characters_binary) do
    (char_count * char_size).times.map { 100 }
  end
  let(:binaries) { characters + characters_binary }
  let(:expected_font) do
    FontHelper::Font.new(width:, height:)
  end

  context 'when no char data is given' do
    let(:char_count) { 0 }

    it do
      expect(described_class.build(width, height, first_char, char_count, *binaries))
        .to be_a(FontHelper::Font)
    end

    it "Returns Font with expected attributes" do
      expect(described_class.build(width, height, first_char, char_count, *binaries))
        .to eq(expected_font)
    end
  end
end
