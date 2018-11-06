require 'oystercard'

describe Oystercard do
  it "text" do
    expect(subject).to be_instance_of(Oystercard)
  end

  it "has a balance of 0" do
    expect(subject.balance).to eq 0
  end

end
