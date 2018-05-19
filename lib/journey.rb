class Journey
  PENALTY_FARE = 6
  MINIMUM_CHARGE = 1
  attr_reader :entry_station
  attr_reader :end_station



  def initialize(entry_station = nil, end_station = nil)
    @entry_station = entry_station
    @end_station = end_station


  end

  def finish(end_station)
    @end_station = end_station
    return self
  end

  def fare
    complete? ? MINIMUM_CHARGE : PENALTY_FARE
  end

  def complete?
    !(@entry_station.nil? || @end_station.nil?)
  end

end
