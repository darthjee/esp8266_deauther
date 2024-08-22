# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::BitMap do
  subject(:bit_map) { described_class.new(binary:, height:) }

  let(:height)      { 28 }
  let(:binary)      { [255] }

  describe '#initialization' do
    let(:binary) { [131] }
    let(:bitmap) { [[1, 1, 0, 0, 0, 0, 0, 1]] }

    context 'when initializing with binary' do
      it 'ínitializes the binary' do
        expect(bit_map.binary).to eq(binary)
      end

      it 'initializes bitmap' do
        expect(bit_map.bitmap).to eq(bitmap)
      end
    end

    context 'when initializing with bitmap' do
      subject(:bit_map) { described_class.new(bitmap:, height:) }

      it 'ínitializes the binary' do
        expect(bit_map.binary).to eq(binary)
      end

      it 'initializes bitmap' do
        expect(bit_map.bitmap).to eq(bitmap)
      end
    end
  end

  describe '#byte_height' do
    context 'when height is 8 or less' do
      let(:height) { Random.rand(1..8) }

      it do
        expect(bit_map.byte_height).to eq(1)
      end
    end

    context 'when height is ibetween 9 and 16' do
      let(:height) { Random.rand(9..16) }

      it do
        expect(bit_map.byte_height).to eq(2)
      end
    end

    context 'when height is ibetween 17 and 24' do
      let(:height) { Random.rand(17..24) }

      it do
        expect(bit_map.byte_height).to eq(3)
      end
    end

    context 'when height is ibetween 25 and 32' do
      let(:height) { Random.rand(25..32) }

      it do
        expect(bit_map.byte_height).to eq(4)
      end
    end
  end

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
          .to change(bit_map, :binary)
          .from([255]).to([254])
      end
    end

    context 'when there is a subsequent change in it' do
      before do
        bit_map.bitmap[0][0] = 0
        bit_map.binary
      end

      it 'changes binary' do
        expect { bit_map.bitmap[0][1] = 0 }
          .to change(bit_map, :binary)
          .from([254]).to([252])
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
      let(:height) { 32 }
      let(:binary) { [255, 254, 252, 248] }
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
      let(:height) { 32 }
      let(:binary) { [255, 254, 252, 248, 240, 224, 192, 128] }
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

    context 'when height is a broken byte' do
      let(:height) { 9 }
      let(:binary) { [255, 1, 128, 1, 3, 0, 0, 1, 4] }
      let(:expected) do
        [
          [1, 1, 1, 1, 1, 1, 1, 1, 1],
          [0, 0, 0, 0, 0, 0, 0, 1, 1],
          [1, 1, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 1],
          [0, 0, 1, 0, 0, 0, 0, 0]
        ]
      end

      it 'returns the remapping into a bitmap' do
        expect(bit_map.bitmap).to eq(expected)
      end
    end
  end

  describe '#bitmap=' do
    it 'changes bitmap' do
      expect { bit_map.bitmap = [[0, 0, 0, 0, 0, 0, 1, 0]] }
        .to change(bit_map, :bitmap)
        .from([[1, 1, 1, 1, 1, 1, 1, 1]])
        .to([[0, 0, 0, 0, 0, 0, 1, 0]])
    end

    it 'changes binary' do
      expect { bit_map.bitmap = [[0, 0, 0, 0, 0, 0, 1, 0]] }
        .to change(bit_map, :binary)
        .from([255])
        .to([64])
    end
  end

  describe '#remove_top' do
    context 'when columns are 1 byte height' do
      let(:height) { 8 }
      let(:binary) { [255, 254, 1] }

      it 'changes binary' do
        expect { bit_map.remove_top }
          .to change(bit_map, :binary)
          .from(binary)
          .to([127, 127, 0])
      end

      it 'does not reduce the byte height' do
        expect { bit_map.remove_top }
          .not_to change(bit_map, :byte_height)
      end

      it 'reduces the height' do
        expect { bit_map.remove_top }
          .to change(bit_map, :height)
          .by(-1)
      end
    end

    context 'when columns are 2 bytes height' do
      let(:height) { 16 }
      let(:binary) { [255, 3, 254, 128, 1, 1] }

      it 'changes binary shifting bytes' do
        expect { bit_map.remove_top }
          .to change(bit_map, :binary)
          .from(binary)
          .to([255, 1, 127, 64, 128, 0])
      end

      it 'does not reduce the byte height' do
        expect { bit_map.remove_top }
          .not_to change(bit_map, :byte_height)
      end

      it 'reduces the height' do
        expect { bit_map.remove_top }
          .to change(bit_map, :height)
          .by(-1)
      end
    end

    context 'when columns are 9 bits high' do
      let(:height) { 9 }
      let(:binary) { [255, 1, 254, 0, 1, 1, 128, 1, 128, 0, 1, 1] }

      it 'changes binary removing the last line' do
        expect { bit_map.remove_top }
          .to change(bit_map, :binary)
          .from(binary)
          .to([255, 127, 128, 192, 64, 128])
      end

      it 'reduces the byte height' do
        expect { bit_map.remove_top }
          .to change(bit_map, :byte_height)
          .by(-1)
      end

      it 'reduces the height' do
        expect { bit_map.remove_top }
          .to change(bit_map, :height)
          .by(-1)
      end
    end

    context 'when passing an argument' do
      let(:height) { 9 }
      let(:binary) { [255, 128, 131] }

      it 'changes binary removing the last line' do
        expect { bit_map.remove_top(2) }
          .to change(bit_map, :binary)
          .from(binary)
          .to([63, 32])
      end

      it 'reduces the byte height' do
        expect { bit_map.remove_top(2) }
          .to change(bit_map, :byte_height)
          .by(-1)
      end

      it 'reduces the height' do
        expect { bit_map.remove_top(2) }
          .to change(bit_map, :height)
          .by(-2)
      end
    end

    context 'when passing 0 as argument' do
      let(:height) { 9 }
      let(:binary) { [255, 128, 131] }

      it 'changes binary removing the last line' do
        expect { bit_map.remove_top(0) }
          .not_to change(bit_map, :binary)
      end

      it 'reduces the byte height' do
        expect { bit_map.remove_top(0) }
          .not_to change(bit_map, :byte_height)
      end

      it 'reduces the height' do
        expect { bit_map.remove_top(0) }
          .not_to change(bit_map, :height)
      end
    end
  end

  describe '#remove_bottom' do
    context 'when columns are 1 byte height' do
      let(:height) { 8 }
      let(:binary) { [255, 254, 1] }

      it 'changes binary' do
        expect { bit_map.remove_bottom }
          .to change(bit_map, :binary)
          .from(binary)
          .to([127, 126, 1])
      end

      it 'does not reduce the byte height' do
        expect { bit_map.remove_top }
          .not_to change(bit_map, :byte_height)
      end

      it 'reduces the height' do
        expect { bit_map.remove_top }
          .to change(bit_map, :height)
          .by(-1)
      end
    end

    context 'when columns are 2 bytes height' do
      let(:height) { 16 }
      let(:binary) { [255, 131, 254, 128, 1, 1, 128, 64] }

      it 'changes binary shifting bytes' do
        expect { bit_map.remove_bottom }
          .to change(bit_map, :binary)
          .from(binary)
          .to([255, 3, 254, 0, 1, 1, 128, 64])
      end

      it 'does not reduce the byte height' do
        expect { bit_map.remove_top }
          .not_to change(bit_map, :byte_height)
      end

      it 'reduces the height' do
        expect { bit_map.remove_top }
          .to change(bit_map, :height)
          .by(-1)
      end
    end

    context 'when columns are 9 bits high' do
      let(:height) { 9 }
      let(:binary) { [255, 1, 254, 0, 1, 1, 128, 1, 128, 0, 1, 1] }

      it 'changes binary removing the last line' do
        expect { bit_map.remove_bottom }
          .to change(bit_map, :binary)
          .from(binary)
          .to([255, 254, 1, 128, 128, 1])
      end

      it 'reduces the byte height' do
        expect { bit_map.remove_top }
          .to change(bit_map, :byte_height)
          .by(-1)
      end

      it 'reduces the height' do
        expect { bit_map.remove_top }
          .to change(bit_map, :height)
          .by(-1)
      end
    end

    context 'when passing an argument' do
      let(:height) { 9 }
      let(:binary) { [255, 1, 254, 0, 128, 1] }

      it 'changes binary removing the last line' do
        expect { bit_map.remove_bottom(2) }
          .to change(bit_map, :binary)
          .from(binary)
          .to([127, 126, 0])
      end

      it 'reduces the byte height' do
        expect { bit_map.remove_bottom(2) }
          .to change(bit_map, :byte_height)
          .by(-1)
      end

      it 'reduces the height' do
        expect { bit_map.remove_bottom(2) }
          .to change(bit_map, :height)
          .by(-2)
      end
    end

    context 'when passing 0 as argument' do
      let(:height) { 9 }
      let(:binary) { [255, 1, 254, 0, 128, 1] }

      it 'changes binary removing the last line' do
        expect { bit_map.remove_bottom(0) }
          .not_to change(bit_map, :binary)
      end

      it 'reduces the byte height' do
        expect { bit_map.remove_bottom(0) }
          .not_to change(bit_map, :byte_height)
      end

      it 'reduces the height' do
        expect { bit_map.remove_bottom(0) }
          .not_to change(bit_map, :height)
      end
    end
  end

  describe '#crop' do
    context 'when cropping top' do
      let(:height) { 8 }
      let(:binary) { [255, 254, 1, 128] }

      it 'changes binary' do
        expect { bit_map.crop(top: 1) }
          .to change(bit_map, :binary)
          .from(binary)
          .to([127, 127, 0, 64])
      end

      it 'reduces the height' do
        expect { bit_map.crop(top: 1) }
          .to change(bit_map, :height)
          .by(-1)
      end
    end

    context 'when cropping bottom' do
      let(:height) { 8 }
      let(:binary) { [255, 254, 1, 128] }

      it 'changes binary' do
        expect { bit_map.crop(bottom: 1) }
          .to change(bit_map, :binary)
          .from(binary)
          .to([127, 126, 1, 0])
      end

      it 'reduces the height' do
        expect { bit_map.crop(bottom: 1) }
          .to change(bit_map, :height)
          .by(-1)
      end
    end

    context 'when cropping top and bottom' do
      let(:height) { 8 }
      let(:binary) { [255, 254, 1, 128] }

      it 'changes binary' do
        expect { bit_map.crop(top: 1, bottom: 1) }
          .to change(bit_map, :binary)
          .from(binary)
          .to([63, 63, 0, 0])
      end

      it 'reduces the height' do
        expect { bit_map.crop(top: 1, bottom: 1) }
          .to change(bit_map, :height)
          .by(-2)
      end
    end
  end

  describe '#bit_at' do
    context 'when bit exist and byte is 1' do
      let(:binary) { [1] }

      context 'when it is 1 do' do
        it do
          expect(bit_map.bit_at(column: 0, line: 0)).to eq(1)
        end
      end

      context 'when it is 0 do' do
        it do
          expect(bit_map.bit_at(column: 0, line: 7)).to eq(0)
        end
      end
    end

    context 'when bit exist and byte is 128' do
      let(:binary) { [128] }

      context 'when it is 0 do' do
        it do
          expect(bit_map.bit_at(column: 0, line: 7)).to eq(1)
        end
      end

      context 'when it is 1 do' do
        it do
          expect(bit_map.bit_at(column: 0, line: 0)).to eq(0)
        end
      end
    end

    context 'when line does not exist' do
      it do
        expect(bit_map.bit_at(column: 0, line: 8)).to eq(0)
      end
    end

    context 'when column does not exist' do
      it do
        expect(bit_map.bit_at(column: 1, line: 0)).to eq(0)
      end
    end
  end

  describe '#trim' do
    let(:height) { 16 }
    let(:binary) { [255, 0, 0, 0, 0, 255, 1, 0, 0, 0] }

    it 'removes last empty bytes' do
      expect { bit_map.trim }
        .to change(bit_map, :binary)
        .from(binary)
        .to([255, 0, 0, 0, 0, 255, 1])
    end
  end

  describe '#flip_vertically' do
    let(:height) { 9 }
    let(:width)  { 4 }

    context 'when columns are complete' do
      let(:binary) { [255, 1, 3, 0, 0, 1, 128, 1] }

      it 'flips the bits vertically' do
        expect { bit_map.flip_vertically }
          .to change(bit_map, :binary)
          .from(binary)
          .to([255, 1, 128, 1, 1, 0, 3, 0])
      end
    end

    context 'when columns is incomplete' do
      let(:binary) { [255, 1, 3, 0, 0, 1, 129] }

      it 'flips the bits vertically' do
        expect { bit_map.flip_vertically }
          .to change(bit_map, :binary)
          .from(binary)
          .to([255, 1, 128, 1, 1, 0, 2, 1])
      end
    end
  end

  describe '#flip_horizontally' do
    let(:height) { 9 }
    let(:width)  { 4 }

    context 'when all columns are present' do
      let(:binary) { [255, 1, 3, 0, 0, 1, 128, 1] }

      it 'flips columns' do
        expect { bit_map.flip_horizontally }
          .to change(bit_map, :binary)
          .from(binary)
          .to([128, 1, 0, 1, 3, 0, 255, 1])
      end
    end
  end
end
