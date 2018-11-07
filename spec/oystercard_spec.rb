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

  describe "#touch_in, #touch_out and #in_journey?" do

    before '#top_up balance' do
      add_money
    end

    it 'when initialized #in_journey? should equal false' do
      expect(subject).not_to be_in_journey
    end

    it 'changes @travelling to true after #touch_in' do
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it 'changes @travelling to false after #touch_out' do
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

    it "will throw an error if balance is less than MINIMUM_FARE" do
      card = Oystercard.new
      expect{card.touch_in}.to raise_error("Insufficient funds")
    end

    it 'deducts MINIMUM_FARE on #touch_out' do
      expect{subject.touch_out}.to change{subject.balance}.by(-1)
    end

  end


end
