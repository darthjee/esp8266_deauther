# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::BinaryConverter do
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
  end
end
