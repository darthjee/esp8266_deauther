# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::Command::Crop do
  subject(:command) { described_class.new(script, top:, bottom:) }

  let(:context)   { FontHelper::ScriptContext.new }
  let(:font)      { build(:font) }
  let(:script)    { FontHelper::Script.new(SecureRandom.hex(32), context:) }

  before do
    context.font = font
  end

  describe '#run' do
    let(:font) { FontHelper::Font.new(width:, height:, characters:) }
    let(:height) { 8 }
    let(:width) { (height * 1.5).to_f }
    let(:top) { 0 }
    let(:bottom) { 1 }

    let(:characters) do
      [
        build(:character, code: 48, height:, binary: [255]),
        build(:character, code: 49, height:, binary: [127]),
        build(:character, code: 51, height:, binary: [128]),
        build(:character, code: 52, height:, binary: [1])
      ]
    end

    context 'when when croping the top' do
      let(:top)    { 1 }
      let(:bottom) { 0 }

      it 'change the heights' do
        expect { command.run }
          .to change { font.characters.values.map(&:height).uniq }
          .from([height]).to([height - 1])
      end

      it 'change the binaries' do
        expect { command.run }
          .to change { font.characters.values.map(&:binary).flatten }
          .from([255, 127, 128, 1])
          .to([127, 63, 64, 0])
      end
    end

    context 'when when croping the bottom' do
      let(:top)    { 0 }
      let(:bottom) { 1 }

      it 'change the heights' do
        expect { command.run }
          .to change { font.characters.values.map(&:height).uniq }
          .from([height]).to([height - 1])
      end

      it 'change the binaries' do
        expect { command.run }
          .to change { font.characters.values.map(&:binary).flatten }
          .from([255, 127, 128, 1])
          .to([127, 127, 0, 1])
      end
    end

    context 'when when croping top and bottom' do
      let(:top)    { 1 }
      let(:bottom) { 1 }

      it 'change the heights' do
        expect { command.run }
          .to change { font.characters.values.map(&:height).uniq }
          .from([height]).to([height - 2])
      end

      it 'change the binaries' do
        expect { command.run }
          .to change { font.characters.values.map(&:binary).flatten }
          .from([255, 127, 128, 1])
          .to([63, 63, 0, 0])
      end
    end
  end
end
