class Oystercard
  attr_reader :balance
  DEFAULT_LIMIT = 90

  def initialize(balance = 0)
    @balance = balance
    @travelling = false
  end

  def top_up(amount)
    check_limit(amount)
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def in_journey?
    @travelling
  end

  def touch_in
    @travelling = true
  end

  def touch_out
    @travelling = false
  end

  private

  def check_limit(amount)
    fail "Balance limit of #{DEFAULT_LIMIT} exceeded" if (@balance + amount) > DEFAULT_LIMIT
  end

end
