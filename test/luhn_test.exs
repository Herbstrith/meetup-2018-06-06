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

  test "sum_digits" do
    assert Luhn.sum_digits(12) == 3
    assert Luhn.sum_digits(13) == 4
    assert Luhn.sum_digits(15) == 6
  end

  test "calculate the luhn digit with string as input" do
    assert Luhn.generate("7992739871") == 3
    assert Luhn.generate("7992739875") == 5
    assert Luhn.generate("1234567890") == 3
    assert Luhn.generate("565487") == 6
    assert Luhn.generate("5654871") == 2
  end

  test "calculate the luhn digit with an integer as input" do
    assert Luhn.generate(7992739871) == 3
    assert Luhn.generate(7992739875) == 5
    assert Luhn.generate(1234567890) == 3
    assert Luhn.generate(565487) == 6
    assert Luhn.generate(5654871) == 2
  end

  test "Should not generate luhn digit for invalid string input (float)" do
    assert Luhn.generate("72132.1") === {:error, "input is not a integer"}
  end

  test "Should not generate luhn digit for invalid input (float)" do
    assert_raise FunctionClauseError, fn ->
      Luhn.generate(72132.1)
    end
  end

end
