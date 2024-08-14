# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::BinaryConverter do
  context 'when byte is full' do
    let(:byte) { 255 }

    it 'returns the remapping into a bits' do
      expect(described_class.to_bits(byte)).to eq([1,1,1,1,1,1,1,1])
    end
  end

  context 'when binary is not all 1' do
    let(:byte) { 170 }

    it 'returns the remapping into a bits' do
      expect(described_class.to_bits(byte)).to eq([0,1,0,1,0,1,0,1])
    end
  end
end
