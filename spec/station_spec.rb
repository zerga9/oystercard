require 'station'

describe Station do
  subject { Station.new('Liverpoolstreet', 3) }

  it 'gives station name' do
    expect(subject.name).to eq 'Liverpoolstreet'
  end

  it 'knows its zone' do
    expect(subject.zone).to eq 3
  end
end
