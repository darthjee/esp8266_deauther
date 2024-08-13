# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::Font do
  subject(:font) { described_class.new(width:, height:, characters:) }

  let(:height) { Random.rand(10..30) }
  let(:width) { (height * 1.5).to_f }
  let(:characters) { build_list(:character, 1) }
  let(:character) { build(:character) }

  describe '#character' do
    let(:characters) { [character] }

    context 'when the character is found' do
      let(:code) { character.code }

      it 'returns the character' do
        expect(font.character(code)).to eq(character)
      end
    end

    context 'when the character is not found' do
      let(:code) { character.code + 1 }

      it 'returns an empty character' do
        expect(font.character(code))
          .to eq(FontHelper::Character.new(width:, code:))
      end
    end
  end

  describe '#<<' do
    context 'when there are not characters' do
      let(:characters) { [] }

      it do
        expect { font << character }
          .to change(font, :size)
          .from(0).to(1)
      end
    end

    context 'when there is already a character' do
      context 'when adding the next character' do
        let(:character) { build(:character, code: font.last_character + 1) }

        it do
          expect { font << character }
            .to change(font, :size)
            .from(1).to(2)
        end
      end

      context 'when adding a character further ahead' do
        let(:character) { build(:character, code: font.last_character + 2) }

        it 'changes the size accordinly' do
          expect { font << character }
            .to change(font, :size)
            .from(1).to(3)
        end
      end
    end

    context 'when there is already the same character' do
      let(:character) { build(:character) }

      it do
        expect { font << character }
          .not_to change(font, :size)
      end

      it do
        expect { font << character }
          .to(change { font.character(character.code) })
      end
    end
  end

  describe '#first_character' do
    let(:characters) do
      [
        build(:character, code: 51),
        build(:character, code: 48),
        build(:character, code: 55)
      ]
    end

    it 'returns the first character code' do
      expect(font.first_character).to eq(48)
    end
  end

  describe '#last_character' do
    let(:characters) do
      [
        build(:character, code: 51),
        build(:character, code: 56),
        build(:character, code: 55)
      ]
    end

    it 'returns the last character code' do
      expect(font.last_character).to eq(56)
    end
  end

  describe '#size' do
    context 'when characters are continuous' do
      let(:characters) do
        [
          build(:character, code: 51),
          build(:character, code: 48),
          build(:character, code: 49),
          build(:character, code: 50)
        ]
      end

      it 'returns the size of the array' do
        expect(font.size).to eq(4)
      end
    end

    context 'when characters are not continuous' do
      let(:characters) do
        [
          build(:character, code: 51),
          build(:character, code: 48)
        ]
      end

      it 'returns the size of the limits' do
        expect(font.size).to eq(4)
      end
    end

    context 'when there are no characters' do
      let(:characters) { [] }

      it 'returns the size of the limits' do
        expect(font.size).to eq(0)
      end
    end
  end

  describe '#each' do
    let(:codes_output) { [] }
    let(:characters_output) { [] }

    before do
      font.each do |code, character|
        codes_output << code
        characters_output << character
      end
    end

    context 'when there is one character' do
      it 'process that single character code' do
        expect(codes_output).to eq([48])
      end

      it 'process that single character' do
        expect(characters_output).to eq(characters)
      end
    end

    context 'when there are more charactes out of order' do
      let(:characters) do
        [
          build(:character, code: 49),
          build(:character, code: 48),
          build(:character, code: 51),
          build(:character, code: 50)
        ]
      end

      let(:expected_characters) do
        [
          build(:character, code: 48),
          build(:character, code: 49),
          build(:character, code: 50),
          build(:character, code: 51)
        ]
      end

      it 'process the characters codes in order' do
        expect(codes_output).to eq([48, 49, 50, 51])
      end

      it 'process the characters in order' do
        expect(characters_output).to eq(expected_characters)
      end
    end

    context 'when missing characters' do
      let(:characters) do
        [
          build(:character, code: 51),
          build(:character, code: 48)
        ]
      end

      let(:expected_characters) do
        [
          build(:character, code: 48),
          build(:character, code: 49, binary: nil, width:),
          build(:character, code: 50, binary: nil, width:),
          build(:character, code: 51)
        ]
      end

      it 'process the characters codes for all missing characters' do
        expect(codes_output).to eq([48, 49, 50, 51])
      end

      it 'process the characters for all missing characters' do
        expect(characters_output).to eq(expected_characters)
      end
    end
  end

  describe '#each_value' do
    let(:characters_output) { [] }

    before do
      font.each_value do |character|
        characters_output << character
      end
    end

    context 'when there is one character' do
      it 'process that single character' do
        expect(characters_output).to eq(characters)
      end
    end

    context 'when there are more charactes out of order' do
      let(:characters) do
        [
          build(:character, code: 49),
          build(:character, code: 48),
          build(:character, code: 51),
          build(:character, code: 50)
        ]
      end

      let(:expected_characters) do
        [
          build(:character, code: 48),
          build(:character, code: 49),
          build(:character, code: 50),
          build(:character, code: 51)
        ]
      end

      it 'process the characters in order' do
        expect(characters_output).to eq(expected_characters)
      end
    end

    context 'when missing characters' do
      let(:characters) do
        [
          build(:character, code: 51),
          build(:character, code: 48)
        ]
      end

      let(:expected_characters) do
        [
          build(:character, code: 48),
          build(:character, code: 49, binary: nil, width:),
          build(:character, code: 50, binary: nil, width:),
          build(:character, code: 51)
        ]
      end

      it 'process the characters for all missing characters' do
        expect(characters_output).to eq(expected_characters)
      end
    end
  end
end
