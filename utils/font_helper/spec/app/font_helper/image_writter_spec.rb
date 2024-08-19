# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::ImageWritter do
  let(:font)      { FontHelper::FontLoader.load(font_path) }
  let(:font_path) { 'spec/support/fixtures/font_simplified.txt' }
  let(:code)      { 48 }
  let(:output)    { "spec/support/fixtures/#{code}.pbm" }
  let(:character) { font.character(code) }

  before do
    File.delete(output) if File.exist?(output)
  end

  it 'creates the file' do
    expect { described_class.write(character, output) }
      .to change { File.exist?(output) }
      .from(false).to(true)
  end
end
