require 'spec_helper'

describe FontHelper::Font do
  subject(:font) { described_class.new(width, height, characters) }

  let(:height) { Random.rand(10..30) }
  let(:width) { (height * 1.5).to_f }
  let(:characters) { build_list(:character, 1) }
  let(:character) { build(:character) }

  describe "#<<" do
    context 'when there are not characters' do
      let(:characters) { [] }

      it do
        expect { font << character }
          .to change(font, :quantity)
          .from(0).to(1)
      end
    end

    context 'where there is already a character' do
      let(:character) { build(:character, code: 50) }

      it do
        expect { font << character }
          .to change(font, :quantity)
          .from(1).to(2)
      end
    end

    context 'where there is already the same character' do
      let(:character) { build(:character) }

      it do
        expect { font << character }
          .not_to change(font, :quantity)
      end
    end
  end
end
