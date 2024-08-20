# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::Command::AddCharacter do
  subject(:command) { described_class.new(script, code:, width:, binary:) }

  let(:code)   { (48..58).to_a.sample }
  let(:width)  { (20..30).to_a.sample }
  let(:height) { (20..30).to_a.sample }
  let(:binary) { [131] }

  let(:font)       { build(:font, characters:, height:) }
  let(:characters) { [build(:character, code: 32, binary: [255])] }

  let(:context)    { FontHelper::ScriptContext.new }
  let(:script)     { FontHelper::Script.new(SecureRandom.hex(32), context:) }

  before do
    context.font = font
  end

  describe '#run' do
    let(:expected_character) do
      FontHelper::Character.new(code:, width:, binary:, height:)
    end

    context 'when adding a binary' do
      it 'add character' do
        expect { command.run }
          .to change { font.characters.values }
          .from(characters)
          .to(characters + [expected_character])
      end
    end

    context 'when missing height' do
      let(:height) { nil }
       
      it 'add character using font height' do
        expect { command.run }
          .to change { font.characters.values }
          .from(characters)
          .to(characters + [expected_character])
      end
    end

    context 'when missing binary' do
      let(:binary) { nil }
       
      it 'add character using font height' do
        expect { command.run }
          .to change { font.characters.values }
          .from(characters)
          .to(characters + [expected_character])
      end
    end
  end
end
