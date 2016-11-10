require 'spec_helper'

describe Geckodriver::Helper do
  let(:helper) { Geckodriver::Helper.new }

  describe '#binary_path' do
    context 'on a linux platform' do
      before { allow(helper).to receive(:platform) { 'linux32' } }
      it { expect(helper.binary_path).to match(/geckodriver$/) }
    end

    context 'on a mac platform' do
      before { allow(helper).to receive(:platform) { 'mac' } }
      it { expect(helper.binary_path).to match(/geckodriver$/) }
    end

    context 'on a windows platform' do
      before { allow(helper).to receive(:platform) { 'win' } }
      it { expect(helper.binary_path).to match(/geckodriver\.exe$/) }
    end
  end
end
