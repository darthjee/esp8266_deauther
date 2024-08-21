# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::Command::WriteImage do
  subject(:command) { described_class.new(script, code:, path:) }

  let(:font)        { FontHelper::FontLoader.load(font_path) }
  let(:font_path)   { 'spec/support/fixtures/font_simplified.txt' }
  let(:path)        { "/tmp/#{code}_#{SecureRandom.hex(16)}.pbm" }
  let(:character)   { font.character(code) }
  let(:sample_path) { "spec/support/fixtures/#{code}.pbm" }
  let(:sample)      { File.read(sample_path) }

  let(:context)    { FontHelper::ScriptContext.new(font:) }
  let(:script)     { FontHelper::Script.new(SecureRandom.hex(32), context:) }

  after do
    FileUtils.rm_f(path)
  end

  (48..58).to_a.each do |cod|
    context "when code is #{cod}" do
      let(:code) { cod }

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
  end
end
