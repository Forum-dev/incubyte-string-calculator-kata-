require 'spec_helper'
require_relative '../lib/string_calculator'

RSpec.describe StringCalculator do
  subject { described_class.new }

  describe '#add' do
    # Basic scenarios
    it 'returns 0 for an empty string' do
      expect(subject.add('')).to eq(0)
    end

    it 'returns the number for a single number string' do
      expect(subject.add('1')).to eq(1)
      expect(subject.add('42')).to eq(42)
    end

    it 'returns sum for two comma-separated numbers' do
      expect(subject.add('1,5')).to eq(6)
      expect(subject.add('0,0')).to eq(0)
    end

    it 'returns sum for arbitrary comma-separated numbers' do
      expect(subject.add('1,2,3')).to eq(6)
      expect(subject.add('1,2,3,4,5')).to eq(15)
    end

    it 'handles newlines between numbers' do
      expect(subject.add("1\n2,3")).to eq(6)
      expect(subject.add("1\n2\n3")).to eq(6)
      expect(subject.add("1,2\n3,4\n5")).to eq(15)
    end

    it 'supports single custom delimiter' do
      expect(subject.add("//;\n1;2")).to eq(3)
      expect(subject.add("//|\n1|2|3")).to eq(6)
      expect(subject.add("//.\n4.5.6")).to eq(15)
    end

    it 'raises exception for single negative number' do
      expect { subject.add('-1') }.to raise_error(RuntimeError, 'negative numbers not allowed -1')
      expect { subject.add('1,-2') }.to raise_error(RuntimeError, 'negative numbers not allowed -2')
    end

    it 'raises exception with all negatives listed' do
      expect { subject.add('-1,2,-3') }.to raise_error(RuntimeError, 'negative numbers not allowed -1,-3')
    end

     # Extras: Ignore >1000
    it 'ignores numbers larger than 1000' do
      expect(subject.add('2,1001')).to eq(2)
      expect(subject.add('1000,1001,500')).to eq(1500)
      expect(subject.add('999,1000,1001')).to eq(1999)
    end

    # Extras: Multi-character delimiters
    it 'supports multi-character custom delimiters' do
      expect(subject.add("//[***]\n1***2***3")).to eq(6)
      expect(subject.add("//[abc]\n4abc5abc6")).to eq(15)
      expect(subject.add("//[**]\n1**2\n3**4")).to eq(10)
    end

    # Extras: Multiple custom delimiters
    it 'supports multiple custom delimiters' do
      expect(subject.add("//[*][%]\n1*2%3")).to eq(6)
      expect(subject.add("//[;][,]\n1;2,3;4")).to eq(10)
      expect(subject.add("//[foo][bar]\n5foo6bar7foo8")).to eq(26)
    end

    # Edge cases
    it 'handles leading or trailing delimiters' do
      expect(subject.add(',1,2')).to eq(3)
      expect(subject.add('1,2,')).to eq(3)
      expect(subject.add("\n1\n2\n")).to eq(3)
      expect(subject.add("//;\n;1;2;")).to eq(3)
    end

    it 'handles multiple consecutive delimiters' do
      expect(subject.add('1,,2')).to eq(3)
      expect(subject.add("1\n\n2")).to eq(3)
      expect(subject.add("//;\n1;;2")).to eq(3)
    end

    it 'handles mixed delimiters with customs' do
      expect(subject.add("//;\n1;2\n3,4")).to eq(10)
    end

    it 'handles empty parts with customs' do
      expect(subject.add("//;\n;1;;2;")).to eq(3)
    end

    it 'raises for negatives with custom delimiters' do
      expect { subject.add("//;\n-1;2;-3") }.to raise_error(RuntimeError, 'negative numbers not allowed -1,-3')
    end

    it 'ignores >1000 with custom delimiters' do
      expect(subject.add("//;\n1;1001;2")).to eq(3)
    end

    it 'handles multi-char with negatives and large numbers' do
      expect { subject.add("//[***]\n1***-2***1001") }.to raise_error(RuntimeError, 'negative numbers not allowed -2')
      expect(subject.add("//[***]\n1***2***1001")).to eq(3)
    end

    it 'handles multiple delimiters with edges' do
      expect { subject.add("//[*][%]\n*1%2*1001% -3") }.to raise_error(RuntimeError, 'negative numbers not allowed -3')
      expect(subject.add("//[*][%]\n1*2%3*4%1001")).to eq(10)
    end
  end
end
