require_relative 'journey'

class Oystercard
  MAXIMUM_BALANCE = 90
  BALANCE_LIMIT = 1
  MINIMUM_CHARGE = 1

  attr_reader :balance
  attr_reader :entry_station
  attr_reader :exit_station
  attr_reader :journeys
  attr_reader :new_journey

  def initialize
    @balance = 0
    @entry_station = entry_station
    @exit_station = exit_station
    @journeys = []
    @new_journey = nil
  end

  def top_up(value)
    raise 'Maximum balance of #{maximum_balance} exceeded' if balance + value > MAXIMUM_BALANCE
    @balance += value
  end

  def touch_in(station)
    raise 'Insufficient balance to touch in' if @balance < BALANCE_LIMIT
    @entry_station = station
    @new_journey = Journey.new
  end

  def touch_out(exit_station)
    deduct(MINIMUM_CHARGE)
    @exit_station = exit_station
    journey = { station: entry_station, exit_station: exit_station }
    @entry_station = nil
    @journeys << journey
    @new_journey = Journey.new
  end

  private

  def deduct(fare)
    @balance -= fare
  end
end
