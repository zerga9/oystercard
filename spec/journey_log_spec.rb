require 'journey_log'


describe JourneyLog do

  describe '#start' do
    it "starts journey" do
      station = double(station)
      expect(subject.start(station)).to eq station
    end
  end

  describe '#end' do
    it "ends journey" do
      end_station = double(end_station)
      expect(subject.end(end_station)).to eq end_station
    end
  end

  describe '#whole_journey' do
    it 'stores the whole journey' do
    subject.start('Liverpoolstreet')
    subject.end('Finsbury Park')
    expect(subject.whole_journey).to include subject.current_journey

  end

end

end
