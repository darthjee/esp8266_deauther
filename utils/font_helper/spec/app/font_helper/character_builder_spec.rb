# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::CharacterBuilder do
  let(:height) { 32 }
  let(:width) { 24 }
  let(:code) { 48 }
  let(:binary) { build(:binary, size: bytes) }
  let(:binaries) { binary }
  let(:start_position) { 0 }
  let(:bytes) { 2 }
  let(:first_byte_1) { start_position / 256 }
  let(:first_byte_2) { start_position % 256 }

  let(:character_information) do
    [first_byte_1, first_byte_2, bytes, width]
  end

  let(:expected_character) do
    FontHelper::Character.new(code:, width:, binary:)
  end

  context 'when binnaries has only character information' do
    it do
      expect(described_class.build(height, code, character_information, *binaries))
        .to be_a(FontHelper::Character)
    end

    it 'Returns Character with expected attributes' do
      expect(described_class.build(height, code, character_information, *binaries))
        .to eq(expected_character)
    end
  end

  context 'when binnaries has onther characters information' do
    let(:start_position) { Random.rand(1..10) }
    let(:binaries) do
      build(:binary, size: start_position) +
        binary +
        build(:binary)
    end

    it do
      expect(described_class.build(height, code, character_information, *binaries))
        .to be_a(FontHelper::Character)
    end

    it 'Returns Character with expected attributes' do
      expect(described_class.build(height, code, character_information, *binaries))
        .to eq(expected_character)
    end
  end
end
