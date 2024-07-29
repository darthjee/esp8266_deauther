# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::Character do
  subject(:character) { described_class.new(code:) }

  describe '#character' do
    context 'when code is a valid character' do
      let(:code) { 48 }

      it 'returns the character from code' do
        expect(character.character).to eq('0')
      end
    end
  end
end
