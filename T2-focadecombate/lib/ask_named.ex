defmodule AskNameD do
  @moduledoc """
  Documentation for `askName`.
  """
  @spec getNameLenth(String.t()) :: non_neg_integer
  def getNameLenth(name) do
    String.length(name)
  end

  @spec getName() :: String.t()
  def getName do
    name = IO.gets("What's your name?")
    nameLength = getNameLenth(name)
    case nameLength do
      nameLength when nameLength > 1 -> String.trim(name)
      _ -> "Anonymous"
    end
  end

  @spec hello() :: none()
  def hello do
    name = getName()

    case name do
      "Gustavo" -> IO.puts("Hello, Myself hehehe")
      name when name != "Gustavo" -> IO.puts("Hello, #{name}")
      _ -> IO.puts("Error in getting your name")
    end
  end
end
