defmodule TestGuessingGame do
  use ExUnit.Case
  doctest GuessingGame

  test "should return true if guess is right" do
    assert GuessingGame.guess(4,4) !== false
  end

  test "should false if is too low" do
    assert GuessingGame.guess(4,5) !== false
  end
end
