# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::Command::Remove do
  subject(:command) { described_class.new(script, *codes) }

  let(:context)   { FontHelper::ScriptContext.new }
  let(:font)      { FontHelper::FontLoader.load(font_path) }
  let(:font_path) { 'spec/support/fixtures/font.txt' }
  let(:script)    { FontHelper::Script.new(SecureRandom.hex(32), context:) }

  before do
    context.font = font
  end

  describe '#run' do
    let(:initial_characters) do
      {
        32 =>FontHelper::Character.new(code: 32, width: 7, binary: nil),
        33 => FontHelper::Character.new(code: 33, width: 16, binary: [170]),
        34 => FontHelper::Character.new(code: 34, width: 10, binary: [221, 218]),
        35 => FontHelper::Character.new(code: 35, width: 26, binary: [202])
      }
    end

    context 'when passing a single code' do
      let(:codes) { [32] }

      let(:expected_characters) do
        {
          33 => FontHelper::Character.new(code: 33, width: 16, binary: [170]),
          34 => FontHelper::Character.new(code: 34, width: 10, binary: [221, 218]),
          35 => FontHelper::Character.new(code: 35, width: 26, binary: [202])
        }
      end

      it 'remove that character' do
        expect { command.run }
          .to change { font.characters }
          .from(initial_characters)
          .to(expected_characters)
      end
    end

    context 'when passing a code from the middle' do
      let(:codes) { [33] }

      let(:expected_characters) do
        {
          32 =>FontHelper::Character.new(code: 32, width: 7, binary: nil),
          34 => FontHelper::Character.new(code: 34, width: 10, binary: [221, 218]),
          35 => FontHelper::Character.new(code: 35, width: 26, binary: [202])
        }
      end

      it 'remove that character' do
        expect { command.run }
          .to change { font.characters }
          .from(initial_characters)
          .to(expected_characters)
      end
    end

    context 'when passing more than one code' do
      let(:codes) { [33, 34] }

      let(:expected_characters) do
        {
          32 =>FontHelper::Character.new(code: 32, width: 7, binary: nil),
          35 => FontHelper::Character.new(code: 35, width: 26, binary: [202])
        }
      end

      it 'remove those characters' do
        expect { command.run }
          .to change { font.characters }
          .from(initial_characters)
          .to(expected_characters)
      end
    end
  end
end
