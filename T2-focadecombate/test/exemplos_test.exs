defmodule TestRectangle do
  use ExUnit.Case
  doctest Rectangle

  test "should calc the area of a square correctly" do
    assert Rectangle.area(2, 2) == 4
  end

  test "a wrong perimeter" do
    assert Rectangle.perimeter(2, 3) == 4
  end
end
