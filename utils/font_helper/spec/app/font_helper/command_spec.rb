# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::Command do
  describe '.for' do
    let(:command)   { 'Open' }
    let(:arguments) { ['spec/support/fixtures/font.txt'] }

    context 'when arguments is an array' do
      it 'initializes the command using the arguments' do
        expect(described_class.for(command:, arguments:))
          .to eq(FontHelper::Command::Open.new(*arguments))
      end
    end

    context 'when arguments is not an array' do
      let(:arguments) { 'spec/support/fixtures/font.txt' }

      it 'initializes the command using the arguments as array' do
        expect(described_class.for(command:, arguments:))
          .to eq(FontHelper::Command::Open.new(arguments))
      end
    end
  end
end
