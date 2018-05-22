require_relative 'journey.rb'

class JourneyLog

  attr_reader :journeys, :current_journey

  def initialize(journey_class = Journey.new)
   @journeys = []
   @current_journey = journey_class
  end

  def start(station)
    @current_journey.start_journey(station)
  end

  def end(station)
    @current_journey.finish(station)
  end

  def whole_journey
    @journeys << @current_journey
  end

end
