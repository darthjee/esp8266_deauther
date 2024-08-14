# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::Script do
  subject(:script) { described_class.new(path) }

  let(:path) { 'spec/support/fixtures/script.yml' }

  describe '#commands' do
    it do
      expect(script.commands).to be_a(Array)
    end

    it do
      expect(script.commands).to all(be_a(FontHelper::Command))
    end
  end

  describe '#run' do
    let(:output_path) { '/tmp/font_output.txt' }
    let(:expected_content) { File.read('spec/support/fixtures/font.txt') }

    after do
      File.delete(output_path)
    end

    it 'loads all commands and write the font' do
      script.run

      expect(File.read(output_path)).to eq(expected_content)
    end
  end
end
