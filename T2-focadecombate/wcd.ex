defmodule WordCount do
  @spec readFile(String.t()) :: no_return()
  def readFile(fileName) do
    try do
      File.stream!(fileName)
      |> Enum.map(&String.trim/1)
      |> printResult()
    catch
      e -> IO.puts("Error: Error on reading file #{e}")
    end
  end

  @spec printResult(String.t()) :: no_return()
  def printResult(text) do
    lineCount = getLineCount(text)
    wordCount = getWordCount(text)
    charCount = getCharactersCount(text)

    IO.puts("#{lineCount} #{wordCount} #{charCount}")
  end

  @spec getCharactersCount(String.t()) :: number()
  def getCharactersCount(text) do
    text
    |> Enum.join(" ")
    |> String.length()
  end

  @spec getWordCount(String.t()) :: number()
  def getWordCount(text) do
    count =
      text
      |> Enum.join(" ")
      |> String.split(" ")
      |> Enum.count()

      count
    end

    @spec getLineCount(String.t()) :: number()
  def getLineCount(text) do
    count =
      text
      |> Enum.count()

    count
  end
end
