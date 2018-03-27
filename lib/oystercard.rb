class Oystercard

  MAXIMUM_BALANCE = 90
  BALANCE_LIMIT = 4

  attr_reader :balance


  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(value)
    fail 'Maximum balance of #{maximum_balance} exceeded' if balance + value > MAXIMUM_BALANCE
    @balance = @balance + value
  end

  def deduct(fare)
    @balance = @balance - fare
  end

  def in_journey?
    @in_use
  end

  def touch_in
    @in_use = true
  end

  def touch_out
    @in_use = false
  end

end
