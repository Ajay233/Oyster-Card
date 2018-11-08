require 'station'

describe Station do
  let(:station_1) {Station.new("East Croydon")}
  let(:station_2) {Station.new("Victoria")}

  it "creates a station" do
    expect(station_1.instance_of?(Station)).to eq true
  end
  it "creates a station called East Croydon" do
    expect(station_1.name).to eq "East Croydon"
  end

  

end
