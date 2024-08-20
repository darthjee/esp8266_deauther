# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::Command::CreateFont do
  subject(:command) { described_class.new(script, height:, width:) }

  let(:height) { Random.rand(8..32) }
  let(:width)  { Random.rand(8..32) }

  let(:expected_font) { FontHelper::Font.new(height:, width:) }
  let(:context)       { FontHelper::ScriptContext.new }
  let(:script)        { FontHelper::Script.new(SecureRandom.hex(32), context:) }

  describe '#run' do
    it 'adds a new font' do
      expect { command.run }
        .to change(context, :font)
        .from(nil)
        .to(expected_font)
    end
  end
end
