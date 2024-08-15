# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::BitMap do
  subject(:bit_map) { described_class.new(binary:, byte_height:) }

  let(:byte_height) { 4 }

  describe 'bitmap' do
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
end
