#Each new term in the Fibonacci sequence is generated by adding the previous two terms. By starting with 1 and 2, the first 10 terms will be:
#
#1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
#
#By considering the terms in the Fibonacci sequence whose values do not exceed four million, find the sum of the even-valued terms.

time = :os.system_time(:micro_seconds)
Stream.unfold({1, 1}, fn
        {a, b} when a < 4000000 -> {a, {b, a + b}}
        _ -> nil
    end
)
|> Stream.filter(&(rem(&1, 2) == 0))
|> Enum.sum
|> IO.inspect
IO.puts 'time: #{ (:os.system_time(:micro_seconds) - time) / 1000000} seconds'

defmodule FibonacciEvenSum do
  def summary(number), do: summary(1, 1, 0, number)
  def summary(_, b, sum, number) when b > number, do: IO.puts sum
  def summary(a, b, sum, number)  when rem(b, 2) == 0, do: summary(a + b, a, sum + b, number)
  def summary(a, b, sum, number), do: summary(a + b, a, sum, number)
end
time = :os.system_time(:micro_seconds)
FibonacciEvenSum.summary(4000000)
IO.puts 'time: #{ (:os.system_time(:micro_seconds) - time) / 1000000} seconds'

time = :os.system_time(:micro_seconds)
Stream.unfold({1, 1, 0}, fn
        {_, b, _} when b > 4000000 -> nil
        {a, b, sum} when rem(b, 2) == 0 -> {sum + b, {a + b, a, sum + b}}
        {a, b, sum} -> {sum, {a + b, a, sum}}
        _ -> nil
    end
)
|> Enum.at(-1)
|> IO.puts
IO.puts 'time: #{ (:os.system_time(:micro_seconds) - time) / 1000000} seconds'
