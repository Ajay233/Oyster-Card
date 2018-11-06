require 'oystercard'



describe Oystercard do
  let(:add_money) {subject.top_up(20)}

  it "text" do
    expect(subject).to be_instance_of(Oystercard)
  end

  it "has a balance of 0" do
    expect(subject.balance).to eq 0
  end

  it "can communicate with #top_up" do
    expect(subject).to respond_to(:top_up).with(1)
  end

  it "can add to value of balance" do
    add_money
    expect(subject.top_up(20)).to eq 40
  end

end
