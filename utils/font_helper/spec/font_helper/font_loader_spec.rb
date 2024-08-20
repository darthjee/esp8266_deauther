# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::FontLoader do
  subject(:loader) { described_class }

  let(:path) { 'spec/support/fixtures/font.txt' }
  let(:height) { 28 }
  let(:expected_font) do
    FontHelper::Font.new(width: 24, height:, characters: expected_characters)
  end
  let(:expected_characters) do
    [
      FontHelper::Character.new(code: 32, width: 7, height:, binary: nil),
      FontHelper::Character.new(code: 33, width: 7, height:, binary: [170]),
      FontHelper::Character.new(code: 34, width: 7, height:, binary: [221, 218]),
      FontHelper::Character.new(code: 35, width: 7, height:, binary: [202])
    ]
  end

  describe '.load' do
    it do
      expect(loader.load(path))
        .to eq(expected_font)
    end
  end
end
