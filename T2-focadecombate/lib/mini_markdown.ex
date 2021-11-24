defmodule MiniMarkdown do
  def to_html(text) do
    text
      |> italics()
      |> bold()
      |> paragraph()
      |> h1()
      |> h2()
  end

  def bold(text) do
    Regex.replace(~r/\*\*(.*)\*\*/,text, "<strong>\\1</strong>")
  end

  def italics(text) do
    Regex.replace(~r/\*(.*)\*/,text, "<bold>\\1</bold>")
  end

  def paragraph(text) do
    Regex.replace(~r/(\r\n|\r|\n|^)+([^\r\n]+)((\r\n|\r|\n)+$)?/,text, "<p>\\2</p>")
  end

  def h1(text) do
    Regex.replace(~r/^# (.*)$/,text, "<h1>\\1</h1>")
  end
  def h2(text) do
    Regex.replace(~r/([#]{2}) (.*)$/,text, "<h2>\\1</h2>")
  end
end
