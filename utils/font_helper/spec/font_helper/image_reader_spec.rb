# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::ImageReader do
  let(:image_path)  { "spec/support/fixtures/#{code}.pbm" }

  let(:font)        { FontHelper::FontLoader.load(font_path) }
  let(:font_path)   { 'spec/support/fixtures/font_simplified.txt' }
  let(:character)   { font.character(code) }

  (48..58).to_a.each do |cod|
    context "when code is #{cod}" do
      let(:code) { cod }

      it 'creates the file with the correct content' do
        expect(described_class.read(code, image_path))
          .to eq(character)
      end
    end
  end
end
