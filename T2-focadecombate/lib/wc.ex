defmodule WordCount do
  def readFile(fileName) do
    try do
      File.stream!(fileName)
      |> Enum.map(&String.trim/1)
      |> printResult()
    catch
      e -> IO.puts("Error: Error on reading file #{e}")
    end
  end

  def printResult(text) do
    lineCount = getLineCount(text)
    wordCount = getWordCount(text)
    charCount = getCharactersCount(text)

    IO.puts("#{lineCount} #{wordCount} #{charCount}")
  end

  def getCharactersCount(text) do
    text
    |> Enum.join(" ")
    |> String.length()
  end

  def getWordCount(text) do
    count =
      text
      |> Enum.join(" ")
      |> String.split(" ")
      |> Enum.count()

    count
  end

  def getLineCount(text) do
    count =
      text
      |> Enum.count()

    count
  end
end
