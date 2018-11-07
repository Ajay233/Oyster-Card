class Oystercard
  attr_reader :balance
  DEFAULT_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize(balance = 0)
    @balance = balance
    @travelling = false
  end

  def top_up(amount)
    check_limit(amount)
    @balance += amount
  end

  def in_journey?
    @travelling
  end

  def touch_in
    fail "Insufficient funds" if insufficient_funds?
    @travelling = true
  end

  def touch_out
    @travelling = false
    deduct(MINIMUM_FARE)
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
