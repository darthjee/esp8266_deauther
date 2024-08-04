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
    []
  end

  describe '.write' do
    it do
      described_class.write(font, tmp_path)
      expect(result).to eq(expected)
    end
  end
end
