require 'station'

describe Station do
  subject { Station.new("test", 3) }

  it 'gives station name' do
    expect(subject.name).to eq "test"
  end

  it 'give a station zone' do
    expect(subject.zone).to eq 3
  end
end
