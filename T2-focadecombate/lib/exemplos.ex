defmodule Rectangle do

  # Exemplo de funções nomeadas
  def area(x, y) do
    x * y
  end

  def perimeter(x, y) do
    2*(x+y)
  end

  # Exemplo de função privada
  #defp diagonal(x, y) do
   # Math.sqrt(x*x + y*y)
  #end

end

# Exemplo de função anonima
_circle_area = fn (r) -> 3.1415*r*r end

# pattern Matching
_handleFileError = fn
  {:ok, data} -> IO.puts "Handling result...#{data}"
  {:error, reason} -> IO.puts "An error has occurred! #{reason}"
end
