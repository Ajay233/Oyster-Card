require_relative "./station.rb"
class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journeys
  DEFAULT_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize(balance = 0)
    @balance = balance
    @entry_station
    @exit_station
    @journeys = []
  end

  def top_up(amount)
    check_limit(amount)
    @balance += amount
  end

  def in_journey?
    !@entry_station.nil?
  end

  def touch_in(station)
    fail "Insufficient funds" if insufficient_funds?
    @entry_station = station.name
    @journeys << {entry: @entry_station}
  end


  def touch_out(station)
    deduct(MINIMUM_FARE)
    @exit_station = station.name
    add_journey
    @entry_station = nil
  end

  private

  def deduct(fare)
    @balance -= fare
  end

  def insufficient_funds?
    @balance < MINIMUM_FARE
  end

  def check_limit(amount)
    fail "Balance limit of #{DEFAULT_LIMIT} exceeded" if (@balance + amount) > DEFAULT_LIMIT
  end

  def add_journey
    @journeys << {entry: @entry_station, exit: @exit_station}
  end

end
