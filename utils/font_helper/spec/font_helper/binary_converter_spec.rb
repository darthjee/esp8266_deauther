# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::BinaryConverter do
  describe '.convert_bytes' do
    let(:bytes) { [255, 128, 1] }
    let(:expected) do
      [
        1, 1, 1, 1, 1, 1, 1, 1,
        0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0
      ]
    end

    it 'returns the remapping into a bits' do
      expect(described_class.convert_bytes(bytes))
        .to eq(expected)
    end
  end

  describe '.to_bits' do
    context 'when byte is full' do
      let(:byte) { 255 }

      it 'returns the remapping into a bits' do
        expect(described_class.to_bits(byte)).to eq([1, 1, 1, 1, 1, 1, 1, 1])
      end
    end

    context 'when binary is not all 1' do
      let(:byte) { 170 }

      it 'returns the remapping into a bits' do
        expect(described_class.to_bits(byte)).to eq([0, 1, 0, 1, 0, 1, 0, 1])
      end
    end

    context 'when binary is all 0' do
      let(:byte) { 0 }

      it 'returns the remapping into a bits' do
        expect(described_class.to_bits(byte)).to eq([0, 0, 0, 0, 0, 0, 0, 0])
      end
    end
  end

  describe '.convert_to_bytes' do
    let(:bits) do
      [
        1, 1, 1, 1, 1, 1, 1, 1,
        0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0
      ]
    end

    it 'returns the array of bytes' do
      expect(described_class.convert_to_bytes(bits))
        .to eq([255, 128, 1])
    end
  end

  describe '.to_bytes' do
    context 'when byte is full' do
      let(:bits) { [1, 1, 1, 1, 1, 1, 1, 1] }

      it 'returns the remapping into a bits' do
        expect(described_class.to_byte(bits)).to eq(255)
      end
    end

    context 'when byte is not full' do
      let(:bits) { [0, 1, 0, 1, 0, 1, 0, 1] }

      it 'returns the remapping into a bits' do
        expect(described_class.to_byte(bits)).to eq(170)
      end
    end

    context 'when byte is empty' do
      let(:bits) { [0, 0, 0, 0, 0, 0, 0, 0] }

      it 'returns the remapping into a bits' do
        expect(described_class.to_byte(bits)).to eq(0)
      end
    end

    context 'when bits are incomplete' do
      let(:bits) { [1, 1, 1, 1, 1, 1] }

      it 'returns the remapping into a bits' do
        expect(described_class.to_byte(bits)).to eq(63)
      end
    end
  end
end
