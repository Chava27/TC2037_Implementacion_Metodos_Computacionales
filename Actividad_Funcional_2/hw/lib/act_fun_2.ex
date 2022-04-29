defmodule Hw.Ariel2 do
  @moduledoc """
  Functions to work with lists in Elixir
  """

  @doc """
  Group contigouous equal elements in al list
  """
  def pack(list), do: do_pack(list,[],[])
  defp do_pack([], _temp, result),
    do: Enum.reverse(result)
  defp do_pack([head|[]],temp,result),
    do: do_pack([],[],[[head|temp]|result])
  #If first two elements are equal
  #pattern matching
  defp do_pack([head, head | tail], temp, result),
    do: do_pack([head|tail],[head|temp], result)
  #first two elements ara different
  defp do_pack([head | tail], temp, result),
    do: do_pack(tail,[], [[head|temp]|result])
end
