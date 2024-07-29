require 'spec_helper'

describe FontHelper::Font do
  subject(:font) { described_class.new(width, height, characters) }

  let(:height) { Random.rand(10..30) }
  let(:width) { (height * 1.5).to_f }
  let(:characters) { build_list(:character, 1) }
  let(:character) { build(:character) }

  describe "#<<" do
    it do
      expect { font << character }.to change(font, :quantity)
    end
  end
end
