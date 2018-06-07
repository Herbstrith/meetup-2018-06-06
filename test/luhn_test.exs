defmodule LuhnTest do
  use ExUnit.Case
  doctest Luhn

  test "invalid digits" do
    assert Luhn.check_number("79a27398713") == false
  end

  test "invalid input string with a space" do
    assert Luhn.check_number("792739871 3") == false
  end

  test "valid digits" do
    assert Luhn.check_number("79427398713") == true
  end

  test "foobar" do
    assert Luhn.foobar(12) == 3
    assert Luhn.foobar(13) == 4
    assert Luhn.foobar(15) == 6
  end

  test "calculate the luhn digit" do
    assert Luhn.generate("7992739871") == 3
    assert Luhn.generate("7992739875") == 5
  end
end
