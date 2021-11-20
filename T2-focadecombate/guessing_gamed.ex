defmodule GuessingGame do
  @moduledoc """
  Documentation for `GuessingGame`.
  """

  @spec genNumber :: number()
  @doc """
  Generate a random number.

  ## Examples

      iex> GuessingGame.genNumber()
      99

  """
  def genNumber do
    Enum.random(0..100)
  end

  @spec guess(number(), number()) :: boolean
  @doc """
  Guess a number.

  ## Examples

      iex> GuessingGame.guess(99, 99)
      true

      iex> GuessingGame.guess(99, 100)
      false

  """
  def guess(number, triedNumber) do
    case triedNumber do
      ^number -> isRight()
      triedNumber when triedNumber > number -> isLower()
      triedNumber when triedNumber < number -> isHigher()
      _ -> raise "Unexpected number: #{number}"
    end
  end

  @spec isRight :: true
  def isRight do
    IO.puts("You guessed it!")
    true
  end

  @spec isLower :: false
  def isLower do
    IO.puts("Too high")
    false
  end

  @spec isHigher :: false
  def isHigher do
    IO.puts("Too low")
    false
  end

  @spec tryNumber(number()) :: no_return()
  def tryNumber(rightNumber) do
    {triedNumber,_} = IO.gets("What's the number?") |> Integer.parse()

    case guess(rightNumber, triedNumber) do
      true ->
        IO.puts("You win!")

      false ->
        IO.puts("Try again.")
        tryNumber(rightNumber)
    end
  end

  @spec play :: no_return()
  def play do
    rightNumber = genNumber()
    IO.puts("I'm thinking of a number between 0 and 100.")
    IO.puts("Try to guess it.")
    tryNumber(rightNumber)
  end
end
