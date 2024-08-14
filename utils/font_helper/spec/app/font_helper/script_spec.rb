# frozen_string_literal: true

require 'spec_helper'

describe FontHelper::Script do
  subject(:script) { described_class.new(path) }

  let(:path) { 'spec/support/fixtures/script.yml' }

  describe '#commands' do
    it do
      expect(script.commands).to be_a(Array)
    end

    it do
      expect(script.commands).to all(be_a(FontHelper::Command))
    end
  end

  describe '#run' do
    xit 'loads all commands and write the font' do

    end
  end
end
