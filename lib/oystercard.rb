class Oystercard
  attr_reader :balance
  DEFAULT_LIMIT = 90

  def initialize(balance = 0)
    @balance = balance

  end

  def top_up(value)
    limit_reached?(value)
    @balance += value
  end

  private

  def limit_reached?(value)
    fail "Balance limit of #{DEFAULT_LIMIT} exceeded" if (@balance + value) > DEFAULT_LIMIT
  end

end
