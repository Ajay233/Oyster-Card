class Oystercard
  attr_reader :balance, :entry_station
  DEFAULT_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize(balance = 0)
    @balance = balance
    @entry_station
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
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
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

end
