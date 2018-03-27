class Oystercard

  MAXIMUM_BALANCE = 90
  BALANCE_LIMIT = 1
  MINIMUM_CHARGE = 1

  attr_reader :balance
  attr_reader :entry_station


  def initialize
    @balance = 0
    @entry_station = entry_station
  end

  def top_up(value)
    fail 'Maximum balance of #{maximum_balance} exceeded' if balance + value > MAXIMUM_BALANCE
    @balance = @balance + value
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    fail "Insufficient balance to touch in" if @balance < BALANCE_LIMIT
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @entry_station = nil 
  end

  private

  def deduct(fare)
    @balance = @balance - fare
  end

end
