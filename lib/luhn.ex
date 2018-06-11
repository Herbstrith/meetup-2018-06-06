defmodule Luhn do

  def generate(number) when is_bitstring(number) do
    unless check_number(number) do
      {:error, "input is not a integer"}
    else
      digitsList = String.to_charlist(number) |> Enum.map(&cast_to_number/1)
      doublesSum = double_digits_sum(digitsList)
      singlesSum = single_digits_sum(digitsList)
      rem((doublesSum + singlesSum) * 9, 10)
    end
  end

  def generate(number) when is_integer(number) do
    digitsList = Integer.to_charlist(number) |> Enum.map(&cast_to_number/1)
    doublesSum = double_digits_sum(digitsList)
    singlesSum = single_digits_sum(digitsList)
    rem((doublesSum + singlesSum) * 9, 10)
  end

  def check_number(number) when is_bitstring(number) do
    Regex.match?(~r/^\d*$/, number)
  end

  def double_digits_sum(number) do
    listToIterate = cond do
      rem(length(number) + 1, 2) != 0 -> tl(number)
      true -> number
    end
    Enum.take_every(listToIterate, 2)
      |> Enum.map(&double/1)
      |> Enum.map(&sum_digits/1)
      |> Enum.sum()
  end

  def single_digits_sum(number) do
    listToIterate = cond do
      rem(length(number) + 1, 2) != 0 -> number
      true -> number
    end
    Enum.take_every(listToIterate, 2)
      |> Enum.sum()
  end

  def cast_to_number(string) do
    string - ?0
  end

  def sum_digits(number) when number > 10 do
    rem(number, 10) + div(number, 10)
  end

  def sum_digits(number), do: number

  defp double(x), do: 2 * x

end
