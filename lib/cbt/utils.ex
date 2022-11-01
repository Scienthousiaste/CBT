defmodule Cbt.Utils do
  @bigint_max_value 9_223_372_036_854_775_807

  @spec parse_id(integer() | String.t()) :: pos_integer()
  def parse_id(raw_id) when is_integer(raw_id) do
    if is_integer_id?(raw_id), do: raw_id, else: nil
  end

  def parse_id(raw_id) when is_binary(raw_id) do
    with id when not is_nil(id) <- parse_integer(raw_id),
         true <- is_integer_id?(id) do
      id
    else
      _ -> nil
    end
  end

  @spec parse_integer(String.t()) :: integer() | nil
  def parse_integer(string) do
    case Integer.parse(string) do
      # strictly verify `string` is an integer, no float allowed here
      {integer, ""} -> integer
      _ -> nil
    end
  end

  defp is_integer_id?(id) when id >= 0 and id <= @bigint_max_value, do: true
  defp is_integer_id?(_), do: false
end
