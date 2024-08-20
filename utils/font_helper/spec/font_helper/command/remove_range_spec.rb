# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::Command::RemoveRange do
  subject(:command) { described_class.new(script, initial, final) }

  let(:context)   { FontHelper::ScriptContext.new }
  let(:font)      { FontHelper::FontLoader.load(font_path) }
  let(:font_path) { 'spec/support/fixtures/font_remove.txt' }
  let(:script)    { FontHelper::Script.new(SecureRandom.hex(32), context:) }

  before do
    context.font = font
  end

  describe '#run' do
    let(:initial_characters) do
      {
        32 => build(:character, code: 32, width: 7, binary: nil),
        33 => build(:character, code: 33, width: 16, binary: [170]),
        34 => build(:character, code: 34, width: 10, binary: [221, 218]),
        35 => build(:character, code: 35, width: 26, binary: [202]),
        36 => build(:character, code: 36, width: 16, binary: [211])
      }
    end

    context 'when passing a single code' do
      let(:initial) { 32 }
      let(:final) { 32 }

      let(:expected_characters) do
        {
          33 => build(:character, code: 33, width: 16, binary: [170]),
          34 => build(:character, code: 34, width: 10, binary: [221, 218]),
          35 => build(:character, code: 35, width: 26, binary: [202]),
          36 => build(:character, code: 36, width: 16, binary: [211])
        }
      end

      it 'remove that character' do
        expect { command.run }
          .to change(font, :characters)
          .from(initial_characters)
          .to(expected_characters)
      end
    end

    context 'when passing a code from the middle' do
      let(:initial) { 33 }
      let(:final) { 33 }

      let(:expected_characters) do
        {
          32 => build(:character, code: 32, width: 7, binary: nil),
          34 => build(:character, code: 34, width: 10, binary: [221, 218]),
          35 => build(:character, code: 35, width: 26, binary: [202]),
          36 => build(:character, code: 36, width: 16, binary: [211])
        }
      end

      it 'remove that character' do
        expect { command.run }
          .to change(font, :characters)
          .from(initial_characters)
          .to(expected_characters)
      end
    end

    context 'when passing more than one code' do
      let(:initial) { 33 }
      let(:final) { 34 }

      let(:expected_characters) do
        {
          32 => build(:character, code: 32, width: 7, binary: nil),
          35 => build(:character, code: 35, width: 26, binary: [202]),
          36 => build(:character, code: 36, width: 16, binary: [211])
        }
      end

      it 'remove those characters' do
        expect { command.run }
          .to change(font, :characters)
          .from(initial_characters)
          .to(expected_characters)
      end
    end

    context 'when passing a bigger range' do
      let(:initial) { 33 }
      let(:final) { 35 }

      let(:expected_characters) do
        {
          32 => build(:character, code: 32, width: 7, binary: nil),
          36 => build(:character, code: 36, width: 16, binary: [211])
        }
      end

      it 'remove those characters' do
        expect { command.run }
          .to change(font, :characters)
          .from(initial_characters)
          .to(expected_characters)
      end
    end
  end
end
