# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::FontWritter do
  let(:fixture_path) { 'spec/support/fixtures/font.txt' }
  let(:expected)     { File.read(fixture_path) }
  let(:tmp_path)     { "/tmp/font_#{SecureRandom.hex(32)}.txt" }
  let(:result)       { File.read(tmp_path) }

  let(:font) do
    FontHelper::Font.new(width: 24, height: 28, characters:)
  end
  let(:characters) do
    [
      FontHelper::Character.new(code: 32, width: 7, binary: nil),
      FontHelper::Character.new(code: 33, width: 16, binary: [170]),
      FontHelper::Character.new(code: 34, width: 10, binary: [221, 218]),
      FontHelper::Character.new(code: 35, width: 26, binary: [202])
    ]
  end

  describe '.write' do
    it do
      described_class.write(font, tmp_path)
      expect(result).to eq(expected)
    end
  end
end
