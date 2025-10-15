require 'spec_helper'
require_relative '../lib/string_calculator'

RSpec.describe StringCalculator do
  subject { described_class.new }

  describe '#add' do
    it 'returns 0 for an empty string' do
      expect(subject.add('')).to eq(0)
    end

    it 'returns the number for a single number string' do
      expect(subject.add('1')).to eq(1)
    end

    it 'returns sum for two comma-separated numbers' do
      expect(subject.add('1,5')).to eq(6)
    end

    it 'returns sum for arbitrary comma-separated numbers' do
      expect(subject.add('1,2,3')).to eq(6)
      expect(subject.add('1,2,3,4,5')).to eq(15)
    end

    it 'handles newlines between numbers' do
      expect(subject.add("1\n2,3")).to eq(6)
    end
  end
end
