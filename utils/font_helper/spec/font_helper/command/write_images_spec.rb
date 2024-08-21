# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::Command::WriteImages do
  subject(:command) { described_class.new(script, path:) }

  let(:font)        { FontHelper::FontLoader.load(font_path) }
  let(:codes)       { (48..58).to_a }
  let(:sample_path) { "spec/support/fixtures/images/#{code}.pbm" }
  let(:sample)      { File.read(sample_path) }
  let(:code)        { codes.sample }
  let(:file_paths)  do
    codes.map { |code| "#{path}#{code}.pbm" }
  end
  let(:font_path)   { 'spec/support/fixtures/font_simplified.txt' }
  let(:path)        { "/tmp/images_#{SecureRandom.hex(32)}/" }
  let(:character)   { font.character(code) }

  let(:context)    { FontHelper::ScriptContext.new(font:) }
  let(:script)     { FontHelper::Script.new(SecureRandom.hex(32), context:) }

  before do
    Dir.mkdir(path)
  end

  after do
    Dir["#{path}/*"].each do |file|
      FileUtils.rm_f(file)
    end
    Dir.rmdir(path)
  end

  it 'creates the files' do
    expect { command.run }
      .to change { file_paths.all? { |path| File.exist?(path) } }
      .from(false).to(true)
  end

  it 'creates the file with the correct content' do
    command.run

    expect(File.read("#{path}/#{code}.pbm")).to eq(sample)
  end
end
