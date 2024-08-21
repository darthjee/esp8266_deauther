# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::Command::WriteImages do
  subject(:command) { described_class.new(script, path:) }

  let(:font)        { FontHelper::FontLoader.load(font_path) }
  let(:font_path)   { 'spec/support/fixtures/font_simplified.txt' }
  let(:path)        { "/tmp/#{code}_#{SecureRandom.hex(16)}.pbm" }
  let(:character)   { font.character(code) }

  let(:context)    { FontHelper::ScriptContext.new(font:) }
  let(:script)     { FontHelper::Script.new(SecureRandom.hex(32), context:) }

  before do
  end

  after do
    FileUtils.rm_f(path)
  end

  let(:codes) { (48..58).to_a }
  let(:sample_path) { "spec/support/fixtures/images/#{code}.pbm" }
  let(:sample)      { File.read(sample_path) }
  it 'creates the file' do
    expect { command.run }
      .to change { File.exist?(path) }
      .from(false).to(true)
  end

  it 'creates the file with the correct content' do
    command.run

    expect(File.read(path)).to eq(sample)
  end
end
