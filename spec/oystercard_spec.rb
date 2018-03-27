require 'oystercard'

describe Oystercard do
  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
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
  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }
    it 'deducts fare from balance' do
      subject.top_up(20)
      expect{ subject.deduct 3 }.to change{ subject.balance }.by -3
    end
  end

  it 'is initially not in journey' do
    expect(subject).not_to be_in_journey
  end
  describe '#touch_in' do
    it 'can touch in' do
      subject.top_up(Oystercard::BALANCE_LIMIT)
      subject.touch_in
      expect(subject).to be_in_journey
    end
    it "doesn't touch in if below minimum balance" do
#      subject.balance == 0, subject has already balance 0
      expect{ subject.touch_in }.to raise_error "Insufficient balance to touch in"
    end
  end
  describe '#touch_out' do
    it 'can touch out' do
      subject.top_up(Oystercard::BALANCE_LIMIT)
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end

end
