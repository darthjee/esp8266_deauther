# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::FileLoader do
  subject(:loader) { described_class }

  let(:path) { "spec/support/fixtures/font.txt" }
  let(:expected_data) do
    [
      24,28,32,4,
      255,255,0,7,
      0,0,1,7,
      0,1,2,7,
      0,3,1,7,
      170,
      221, 218,
      202
    ]
  end

  describe ".read" do
    it do
      expect(loader.read(path))
        .to eq(expected_data)
    end
  end
end
