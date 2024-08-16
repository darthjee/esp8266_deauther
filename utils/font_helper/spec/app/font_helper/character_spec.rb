# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::Character do
  subject(:character) { build(:character, code:, binary:, height:) }

  let(:binary)      { nil }
  let(:code)        { 48 }
  let(:height)      { 28 }

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
        expect(character.binary)
          .to eq([])
      end
    end
  end

  describe '#remove_top' do
    let(:height) { 8 }
    let(:binary) { [255, 254, 1] }

    it 'changes binary' do
      expect { character.remove_top }
        .to change(character, :binary)
        .from(binary)
        .to([127, 127, 0])
    end
  end
end
