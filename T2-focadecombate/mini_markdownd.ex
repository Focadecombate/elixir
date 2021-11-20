defmodule MiniMarkdown do
  @spec to_html(String.t()) :: String.t()
  def to_html(text) do
    text
    |> italics()
    |> bold()
    |> paragraph()
    |> h1()
    |> h2()
  end

  @spec bold(String.t()) :: String.t()
  def bold(text) do
    Regex.replace(~r/\*\*(.*)\*\*/,text, "<strong>\\1</strong>")
  end

  @spec italics(String.t()) :: String.t()
  def italics(text) do
    Regex.replace(~r/\*(.*)\*/,text, "<bold>\\1</bold>")
  end

  @spec paragraph(String.t()) :: String.t()
  def paragraph(text) do
    Regex.replace(~r/(\r\n|\r|\n|^)+([^\r\n]+)((\r\n|\r|\n)+$)?/,text, "<p>\\2</p>")
  end

  @spec h1(String.t()) :: String.t()
  def h1(text) do
    Regex.replace(~r/^# (.*)$/,text, "<h1>\\1</h1>")
  end

  @spec h2(String.t()) :: String.t()
  def h2(text) do
  Regex.replace(~r/([#]{2}) (.*)$/,text, "<h2>\\1</h2>")
end
