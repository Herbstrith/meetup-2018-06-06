defmodule LuhnTest do
  use ExUnit.Case
  doctest Luhn

  test "Should calculate the luhn digit with string as input" do
    assert Luhn.generate_check_digit("7992739871") == 3
    assert Luhn.generate_check_digit("7992739875") == 5
    assert Luhn.generate_check_digit("1234567890") == 3
    assert Luhn.generate_check_digit("565487") == 6
    assert Luhn.generate_check_digit("5654871") == 2
  end

  test "Should calculate the luhn digit with an integer as input" do
    assert Luhn.generate_check_digit(7992739871) == 3
    assert Luhn.generate_check_digit(7992739875) == 5
    assert Luhn.generate_check_digit(1234567890) == 3
    assert Luhn.generate_check_digit(565487) == 6
    assert Luhn.generate_check_digit(5654871) == 2
  end

  test "Should not generate luhn digit for invalid string input (float)" do
    assert Luhn.generate_check_digit("72132.1") == {:error, "input is not a integer"}
  end

  test "Should not generate luhn digit for invalid input (float)" do
    assert_raise FunctionClauseError, fn ->
      Luhn.generate_check_digit(72132.1)
    end
  end

  test "Should not generate luhn digit for invalid string input (contains letters)" do
    assert Luhn.generate_check_digit("79a27398713") == {:error, "input is not a integer"}
  end

  test "Should not generate luhn digit for invalid string input (contains space)" do
    assert Luhn.generate_check_digit("792739871 3") == {:error, "input is not a integer"}
  end

end
