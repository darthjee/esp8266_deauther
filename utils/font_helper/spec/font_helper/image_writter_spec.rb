# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::ImageWritter do
  let(:font)        { FontHelper::FontLoader.load(font_path) }
  let(:font_path)   { 'spec/support/fixtures/font_simplified.txt' }
  let(:output)      { "/tmp/#{code}_#{SecureRandom.hex(16)}.pbm" }
  let(:character)   { font.character(code) }
  let(:sample_path) { "spec/support/fixtures/images/#{code}.pbm" }
  let(:sample)      { File.read(sample_path) }

  after do
    FileUtils.rm_f(output)
  end

  (48..58).to_a.each do |cod|
    context "when code is #{cod}" do
      let(:code) { cod }

      it 'creates the file' do
        expect { described_class.write(character, output) }
          .to change { File.exist?(output) }
          .from(false).to(true)
      end

      it 'creates the file with the correct content' do
        described_class.write(character, output)

        expect(File.read(output)).to eq(sample)
      end
    end
  end
end
