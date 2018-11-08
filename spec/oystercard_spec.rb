require 'oystercard'

describe Oystercard do
  let(:add_money) { subject.top_up(20) }
  let(:top_up_max) { subject.top_up(Oystercard::DEFAULT_LIMIT) }
  let(:default_limit) { Oystercard::DEFAULT_LIMIT }
  let(:croydon) { double :entry_station }
  let(:victoria) { double :exit_station }

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
      allow(croydon).to receive(:name).and_return("East Croydon")
      subject.touch_in(croydon)
      expect(subject).to be_in_journey
    end

    it 'changes @travelling to false after #touch_out' do
      allow(croydon).to receive(:name).and_return("East Croydon")
      subject.touch_in(croydon)
      allow(victoria).to receive(:name).and_return("Victoria")
      subject.touch_out(victoria)
      expect(subject).not_to be_in_journey
    end

    it "will throw an error if balance is less than MINIMUM_FARE" do
      card = Oystercard.new
      allow(croydon).to receive(:name).and_return("East Croydon")
      expect{card.touch_in(croydon)}.to raise_error("Insufficient funds")
    end

    it 'deducts MINIMUM_FARE on #touch_out' do
      allow(victoria).to receive(:name).and_return("Victoria")
      expect{subject.touch_out(victoria)}.to change{subject.balance}.by(-1)
    end

    it "#touch_in to store the entry station" do\
      allow(croydon).to receive(:name).and_return("East Croydon")
      subject.touch_in(croydon)
      expect(subject.entry_station).to eq "East Croydon"
    end

    it 'initilizes with an empty @journeys array' do
      expect(subject.journeys).to be_empty
    end

  end

  describe "@journeys" do

    in_out_card = Oystercard.new(10)

    it "#touch_out sets @entry_station to nil" do
      expect(in_out_card.entry_station).to eq nil
    end
  end

  describe '#touch_out' do
    context 'having already touched in' do
      let(:in_out_card) { Oystercard.new(10) }

      before do
        allow(croydon).to receive(:name).and_return("East Croydon")
        allow(victoria).to receive(:name).and_return("Victoria")
        in_out_card.touch_in(croydon)
      end

      it 'will store @entry_station and exit station on #touch_out' do
        in_out_card.touch_out(victoria)
        expect(in_out_card.journeys).to include({:entry => "East Croydon", :exit => "Victoria"})
      end

      it 'creates one journey after touching in and out' do
        in_out_card.touch_out(victoria)
        expect(in_out_card.journeys.length).to eq 1
      end

      it "exit station initialized to nil" do
        expect(subject.exit_station).to eq nil
      end
      it "#touch_in to store the entry station" do
        subject.touch_out(victoria)
        expect(subject.exit_station).to eq "Victoria"
      end

    end
  end


end
