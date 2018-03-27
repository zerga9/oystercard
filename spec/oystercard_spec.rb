require 'oystercard'

describe Oystercard do
  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end
  it 'has an empty list of journeys by default' do
    expect(subject.journeys).to be_empty
  end

  describe '#top-up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }
    it 'can top up balance' do
      expect{ subject.top_up 5 }.to change{ subject.balance }.by 5
    end
    it 'raises an error if maximum balance is exceeded' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect{ subject.top_up 1 }.to raise_error 'Maximum balance of #{maximum_balance} exceeded'
    end
  end
  it 'is initially not in journey' do
    expect(subject).not_to be_in_journey
  end
  describe '#touch_in' do
    let(:station){ double :station }
    it 'can touch in' do
      subject.top_up(Oystercard::BALANCE_LIMIT)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end
    it "doesn't touch in if below minimum balance" do
#      subject.balance == 0, subject has already balance 0
      expect{ subject.touch_in(station) }.to raise_error "Insufficient balance to touch in"
    end
    it 'remembers entry station' do
      subject.top_up(Oystercard::BALANCE_LIMIT)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end

  end
  describe '#touch_out' do
    let(:station) { double :station }
    let(:exit_station) { double :station }
    let(:journey) { {station: station, exit_station: exit_station} }
    it 'remembers exit station' do
      subject.top_up(Oystercard::BALANCE_LIMIT)
      subject.touch_in(station)
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq exit_station
    end
    it 'can touch out' do
      subject.top_up(Oystercard::BALANCE_LIMIT)
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end
    it 'deducts minimum charge from balance' do
      subject.touch_out(exit_station)
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Oystercard::MINIMUM_CHARGE)
    end
    it 'stores a journey' do
      subject.top_up(Oystercard::BALANCE_LIMIT)
      subject.touch_in(station)
      subject.touch_out(exit_station)
      expect(subject.journeys).to include journey
    end
end
end
