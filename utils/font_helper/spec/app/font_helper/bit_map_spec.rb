# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::BitMap do
  subject(:bit_map) { described_class.new(binary:, byte_height:) }

  let(:byte_height) { 4 }
  let(:binary)      { [255] }

  describe '#binary' do
    context 'when it has been initialized' do
      let(:binary) { [32, 25] }

      it 'returns the binary' do
        expect(bit_map.binary)
          .to eq(binary)
      end
    end

    context 'when it has not been initialized' do
      let(:binary) { nil }

      it 'returns an empty array' do
        expect(bit_map.binary)
          .to eq([])
      end
    end
  end

  describe '#bitmap' do
    context 'when there is a change in it' do
      it 'changes binary' do
        expect { bit_map.bitmap[0][0] = 0 }
          .to change { bit_map.binary }
          .from([255]).to([254])
      end
    end

    context 'when there is only one byte' do
      context 'when binary describes a single column' do
        let(:binary) { [255] }

        it 'returns the remapping into a bitmap' do
          expect(bit_map.bitmap).to eq([[1, 1, 1, 1, 1, 1, 1, 1]])
        end
      end

      context 'when binary is not all 1' do
        let(:binary) { [170] }

        it 'returns the remapping into a bitmap' do
          expect(bit_map.bitmap).to eq([[0, 1, 0, 1, 0, 1, 0, 1]])
        end
      end
    end

    context 'when there is only one full column' do
      let(:binary) { [255,254,252,248] }
      let(:expected) do
        [
          [
            1, 1, 1, 1, 1, 1, 1, 1,
            0, 1, 1, 1, 1, 1, 1, 1,
            0, 0, 1, 1, 1, 1, 1, 1,
            0, 0, 0, 1, 1, 1, 1, 1
          ]
        ]
      end

      it 'returns the remapping into a bitmap' do
        expect(bit_map.bitmap).to eq(expected)
      end
    end

    context 'when there is only mode than column' do
      let(:binary) { [255,254,252,248,240,224,192,128] }
      let(:expected) do
        [
          [
            1, 1, 1, 1, 1, 1, 1, 1,
            0, 1, 1, 1, 1, 1, 1, 1,
            0, 0, 1, 1, 1, 1, 1, 1,
            0, 0, 0, 1, 1, 1, 1, 1
          ],
          [
            0, 0, 0, 0, 1, 1, 1, 1,
            0, 0, 0, 0, 0, 1, 1, 1,
            0, 0, 0, 0, 0, 0, 1, 1,
            0, 0, 0, 0, 0, 0, 0, 1
          ]
        ]
      end

      it 'returns the remapping into a bitmap' do
        expect(bit_map.bitmap).to eq(expected)
      end
    end
  end
end
