require 'journey'

describe Journey do

  subject(:journey) { described_class.new }

  let(:entry_station) { double("entry_station")}
  let(:end_station) { double("end_station") }

  it 'knows if a journey is not complete' do
    expect(subject).not_to be_complete
  end
  it 'has a penalty fare by default' do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

    it 'has an entry station' do
      subject.start_journey(entry_station)
      expect(subject.entry_station).to eq entry_station
    end
    it 'has an end station' do
      subject.finish(end_station)
      expect(subject.end_station).to eq end_station
    end
    it 'returns a penalty fare if no exit station given' do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    it 'calculates a fare' do
      allow(entry_station).to receive(:zone).and_return(1)
      allow(end_station).to receive(:zone).and_return(1)
      subject.start_journey(entry_station)
      subject.finish(end_station)
      expect(subject.fare).to eq 1
    end

    it "knows if a journey is complete" do
      subject.start_journey(entry_station)
      subject.finish(end_station)
        expect(subject).to be_complete
      end

    it 'calculates a fare for zone 1 to zone 1' do
        expect(entry_station).to receive(:zone).and_return(1)
        expect(end_station).to receive(:zone).and_return(1)
        subject.start_journey(entry_station)
        subject.finish(end_station)
        expect(subject.fare).to eq 1
      end

      it "calculates a fare for different zones" do
        expect(entry_station).to receive(:zone).and_return(1)
        expect(end_station).to receive(:zone).and_return(4)
        subject.start_journey(entry_station)
        subject.finish(end_station)
        expect(subject.fare).to eq 4
      end
  end
