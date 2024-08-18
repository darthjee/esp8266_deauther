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
    let(:expected_content) { File.read(expected_result_file) }
    let(:expected_result_file) { 'spec/support/fixtures/font.txt' }

    after do
      File.delete(output_path)
    end

    context 'when scripts loads and writes a font' do
      let(:path) { 'spec/support/fixtures/script.yml' }
      let(:expected_result_file) { 'spec/support/fixtures/font.txt' }

      it 'loads all commands and write the font' do
        script.run

        expect(File.read(output_path)).to eq(expected_content)
      end
    end

    context 'when scripts loads and deletes characters' do
      let(:path) { 'spec/support/fixtures/script_removing_characters.yml' }
      let(:expected_result_file) do
        'spec/support/fixtures/font_lacking_characters.txt'
      end

      it 'loads all commands and write the font' do
        script.run

        expect(File.read(output_path)).to eq(expected_content)
      end
    end

    context 'when scripts loads and crops characters' do
      let(:output_path) { '/tmp/font_croped.txt' }
      let(:path) { 'spec/support/fixtures/script_croping.yml' }
      let(:expected_result_file) do
        'spec/support/fixtures/font_croped.txt'
      end

      it 'loads all commands and write the font' do
        script.run

        expect(File.read(output_path)).to eq(expected_content)
      end
    end
  end
end
