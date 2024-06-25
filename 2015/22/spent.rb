class Spent
  attr_reader :amount

  def amount=(amt)
    if @amount && (!amt || @amount < amt)
      @amount
    else
      @amount = amt
    end
  end
end
