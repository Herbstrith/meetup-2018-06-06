defmodule Luhn do

  def validate(number) when is_bitstring(number) do
    unless check_number(number) do
      {:error, "input is not a integer"}
    else
      digitsList = String.to_charlist(number)
      [luhnDigit | digitsListReversed] = Enum.reverse(digitsList)
      cast_to_number(luhnDigit) == generate(Enum.reverse(digitsListReversed))
    end
  end

  def generate_check_digit(number) when is_bitstring(number) do
    unless check_number(number) do
      {:error, "input is not a integer"}
    else
      generate(String.to_charlist(number))
    end
  end

  def generate_check_digit(number) when is_integer(number) do
    generate(Integer.to_charlist(number))
  end

  def generate(number) do
    digitsList = Enum.map(number, &cast_to_number/1)
    doublesSum = double_digits_sum(digitsList)
    singlesSum = single_digits_sum(digitsList)
    rem((doublesSum + singlesSum) * 9, 10)
  end

  defp check_number(number) when is_bitstring(number) do
    Regex.match?(~r/^\d*$/, number)
  end

  defp double_digits_sum(number) do
    listToIterate = cond do
      rem(length(number) + 1, 2) != 0 -> tl(number)
      true -> number
    end
    Enum.take_every(listToIterate, 2)
      |> Enum.map(&double/1)
      |> Enum.map(&sum_digits/1)
      |> Enum.sum()
  end

  defp single_digits_sum(number) do
    listToIterate = cond do
      rem(length(number) + 1, 2) != 0 -> number
      true -> number
    end
    Enum.take_every(listToIterate, 2)
      |> Enum.sum()
  end

  defp cast_to_number(string) do
    string - ?0
  end

  defp sum_digits(number) when number > 10 do
    rem(number, 10) + div(number, 10)
  end

  defp sum_digits(number), do: number

  defp double(x), do: 2 * x

end
