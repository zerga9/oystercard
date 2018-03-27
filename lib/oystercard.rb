class Oystercard

  MAXIMUM_BALANCE = 90
  BALANCE_LIMIT = 1
  MINIMUM_CHARGE = 1

  attr_reader :balance


  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(value)
    fail 'Maximum balance of #{maximum_balance} exceeded' if balance + value > MAXIMUM_BALANCE
    @balance = @balance + value
  end

  def in_journey?
    @in_use
  end

  def touch_in
    fail "Insufficient balance to touch in" if @balance < BALANCE_LIMIT
    @in_use = true
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @in_use = false
  end

  private

  def deduct(fare)
    @balance = @balance - fare
  end

end
