defmodule FizzBuzz do
  def build(file_name) do
    # case File.read(file_name) do
    #   {:ok, result} -> result
    #   {:error, reason} -> reason
    # end
    # file = File.read!(file_name)
    # handle_file_read(file)
    file_name
    |> File.read()
    |> handle_file_read()
  end

  defp handle_file_read({:ok, result}) do
    # list = String.split(result, ',')
    # Enum.map(list, &String.to_integer/1) # Enum.map(list, fn number -> String.to_integer() end)
    # |> Enum.map(&String.to_integer/1)
    result =
      result
      |> String.split(",")
      |> Enum.map(&convert_and_evaluate_numbers/1)

    {:ok, result}
  end

  defp handle_file_read({:error, reason}), do: {:error, "Error reading the file: #{reason}"}

  defp convert_and_evaluate_numbers(elem) do
    # number = String.to_integer(elem)
    # evaluate_numbers(number)

    elem
    |> String.to_integer()
    |> evaluate_numbers()
  end

  defp evaluate_numbers(number) when rem(number, 3) == 0 and rem(number, 5) == 0, do: :fizzbuzz
  defp evaluate_numbers(number) when rem(number, 3) == 0, do: :fizz
  defp evaluate_numbers(number) when rem(number, 5) == 0, do: :buzz
  defp evaluate_numbers(number), do: number
end

# iex -S mix
