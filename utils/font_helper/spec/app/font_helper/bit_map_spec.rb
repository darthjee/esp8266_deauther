# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::BitMap do
  subject(:bit_map) { described_class.new(binary:, height:) }

  let(:height)      { 28 }
  let(:binary)      { [255] }

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
  end
end
