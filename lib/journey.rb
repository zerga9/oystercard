require_relative './station'

class Journey
  PENALTY_FARE = 6
  MINIMUM_CHARGE = 1
  attr_reader :entry_station
  attr_reader :end_station



  def initialize
    @entry_station = nil
    @end_station = nil
    @charge = MINIMUM_CHARGE
  end

  def start_journey(entry_station = Station.new(name, zone))
    @entry_station = entry_station
  end

  def finish(end_station=Station.new(name, zone))
    @end_station = end_station
  end

  def fare
    !complete? ? @charge = PENALTY_FARE : @charge += zone_charge
  end

 def zone_charge
   (entry_station.zone - end_station.zone).abs
 end



  def complete?
    !(@entry_station.nil? || @end_station.nil?)
  end

end
