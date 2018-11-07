require 'oystercard'

describe Oystercard do
  let(:add_money) { subject.top_up(20) }
  let(:top_up_max) { subject.top_up(Oystercard::DEFAULT_LIMIT) }
  let(:default_limit) { Oystercard::DEFAULT_LIMIT }

  it "text" do
    expect(subject).to be_instance_of(Oystercard)
  end

  it "has a balance of 0" do
    expect(subject.balance).to eq 0
  end

  describe "#top_up" do

    it "can communicate with #top_up" do
      expect(subject).to respond_to(:top_up).with(1)
    end

    it "can add to value of balance" do
      add_money
      expect(subject.top_up(20)).to eq 40
    end

    it "will throw an error if balance exceeds 90" do
      top_up_max
      expect{subject.top_up(1)}.to raise_error("Balance limit of #{default_limit} exceeded")
    end

  end
end
