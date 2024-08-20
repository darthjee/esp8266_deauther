# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::Command::ReadImage do
  subject(:command) { described_class.new(script, code:, path:) }

  let(:code)      { (48..58).to_a.sample }
  let(:path)      { "spec/support/fixtures/#{code}.pbm" }

  let(:font)       { build(:font, characters: characters) }
  let(:characters) { [build(:character, code:, binary: [255])] }

  let(:context)    { FontHelper::ScriptContext.new }
  let(:script)     { FontHelper::Script.new(SecureRandom.hex(32), context:) }

  before do
    context.font = font
  end

  describe '#run' do
    it do
      expect { command.run }
        .to change { font.character(code) }
        .from(characters.first)
    end
  end
end
