require 'station'

describe Station do
  let(:station_1) {Station.new("East Croydon", 6)}
  let(:station_2) {Station.new("Victoria", 1)}

  it "creates a station" do
    expect(station_1.instance_of?(Station)).to eq true
  end
  it "creates a station called East Croydon" do
    expect(station_1.name).to eq "East Croydon"
  end

  it "sets east croydon in zone 6" do
    expect(station_1.zone).to eq 6
  end

end
