# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::Command do
  describe '.for' do
    let(:command)   { 'Open' }
    let(:arguments) { ['spec/support/fixtures/font.txt'] }
    let(:script)    { FontHelper::Script.new(SecureRandom.hex(32)) }

    context 'when arguments is an array' do
      it 'initializes the command using the arguments' do
        expect(described_class.for(command:, script:, arguments:))
          .to eq(FontHelper::Command::Open.new(script, *arguments))
      end
    end

    context 'when arguments is not an array' do
      let(:arguments) { 'spec/support/fixtures/font.txt' }

      it 'initializes the command using the arguments as array' do
        expect(described_class.for(command:, script:, arguments:))
          .to eq(FontHelper::Command::Open.new(script, arguments))
      end
    end
  end
end
