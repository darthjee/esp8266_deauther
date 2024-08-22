# frozen_string_literal: true

require 'spec_helper'

describe Array do
  subject(:array) { [ 1, 2, 3, 4, 5, 6, 7, 8] }

  describe '#ensure_size' do
    context 'when array has the right size' do
      let(:size) { 8 }

      it do
        expect { array.ensure_size!(size, 0)  }
          .to not_change(array, :size)
      end

      it 'does not change array content' do
        expect { array.ensure_size!(size, 0)  }
          .to not_change { array }
      end

      it 'returns the array' do
        expect(array.ensure_size!(size, 0))
          .to be(array)
      end
    end

    context 'when array has a bigger size' do
      let(:size) { 5 }

      it 'reduces the array' do
        expect { array.ensure_size!(size, 0)  }
          .to change(array, :size)
          .by(-3)
      end

      it 'crop array content' do
        expect { array.ensure_size!(size, 0)  }
          .to change { array }
          .from(array.dup)
          .to([1,2,3,4,5])
      end

      it 'returns the array' do
        expect(array.ensure_size!(size, 0))
          .to be(array)
      end
    end

    context 'when array has a smaller size' do
      let(:size) { 10 }

      it 'increases the array' do
        expect { array.ensure_size!(size, 0)  }
          .to change(array, :size)
          .by(2)
      end

      it 'complete array content' do
        expect { array.ensure_size!(size, 0)  }
          .to change { array }
          .from(array.dup)
          .to([1,2,3,4,5,6,7,8,0,0])
      end

      it 'returns the array' do
        expect(array.ensure_size!(size, 0))
          .to be(array)
      end
    end
  end
end
