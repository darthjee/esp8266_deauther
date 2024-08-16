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
    context 'when columns are 1 byte height' do
      let(:height) { 8 }
      let(:binary) { [255, 254, 1] }

      it 'changes binary' do
        expect { character.remove_top }
          .to change(character, :binary)
          .from(binary)
          .to([127, 127, 0])
      end

      it 'reduces the height' do
        expect { character.remove_top }
          .to change(character, :height)
          .by(-1)
      end
    end

    context 'when columns are 2 bytes height' do
      let(:height) { 16 }
      let(:binary) { [255, 3, 254, 128, 1, 1] }

      it 'changes binary shifting bytes' do
        expect { character.remove_top }
          .to change(character, :binary)
          .from(binary)
          .to([255, 1, 127, 64, 128, 0])
      end

      it 'reduces the height' do
        expect { character.remove_top }
          .to change(character, :height)
          .by(-1)
      end
    end

    context 'when columns are 9 bits high' do
      let(:height) { 9 }
      let(:binary) { [255, 1, 254, 0, 1, 1] }

      it 'changes binary removing the last line' do
        expect { character.remove_top }
          .to change(character, :binary)
          .from(binary)
          .to([255, 127, 128])
      end

      it 'reduces the height' do
        expect { character.remove_top }
          .to change(character, :height)
          .by(-1)
      end
    end
  end
end
