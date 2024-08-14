# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::Character do
  subject(:character) { build(:character, code:, binary:) }

  let(:binary) { nil }
  let(:code)   { 48 }

  describe '#character' do
    context 'when code is a valid character' do
      it 'returns the character from code' do
        expect(character.character).to eq('0')
      end
    end
  end

  describe '#binary' do
    context 'when it has been initialized' do
      let(:binary) { [32, 25] }

      it 'returns the binary' do
        expect(character.binary)
          .to eq(binary)
      end
    end

    context 'when it has not been initialized' do
      let(:binary) { nil }

      it 'returns an empty array' do
        expect(character.binary).to eq([])
      end
    end
  end

  describe 'bitmap' do
    context 'when binary describes a single column' do
      let(:binary) { [255] }

      it 'returns the remapping into a bitmap' do
        expect(character.bitmap).to eq([[1, 1, 1, 1, 1, 1, 1, 1]])
      end
    end

    context 'when binary is not all 1' do
      let(:binary) { [170] }

      it 'returns the remapping into a bitmap' do
        expect(character.bitmap).to eq([[0, 1, 0, 1, 0, 1, 0, 1]])
      end
    end
  end
end
